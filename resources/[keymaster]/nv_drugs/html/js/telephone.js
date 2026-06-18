var isPhoneVisibleForNotification = false;
function togglePhoneUI(show, fromLua) {
    if (show) {
        isPhoneVisibleForNotification = false;
        $("#telephone-container").stop().css('display', 'block').animate({
            bottom: '1vw'
        }, 300);
    } else {
        $("#telephone-container").stop().animate({
            bottom: '-60%'
        }, 300, function() {
            $(this).css('display', 'none');
        });
        if (!fromLua) {
            $.post('https://nv_drugs/phoneExit');
        }
    }
}

$(document).keydown(function(e) {
    if (e.keyCode === 27) { 
        if ($("#telephone-container").is(":visible")) {
            togglePhoneUI(false);
        }
    }
});

var currentDisplayedConversationId;

$('.menu-icon').click(function() {
    var targetWindow = $(this).data('target');
    $('.menu-window').hide(); 
    $(targetWindow).show();

    if (targetWindow === '#messages-window') {
        resetNewMessagesCount();
    }
});

$('#telephone-button-menu, #telephone-button-back').click(function() {
    if ($('#menu').is(':visible') || blurActive) {
        return;
    }

    $('.menu-window').hide(); 

    $('#menu').show();
});

$('#message-back').click(function() {
    resetNewMessagesCount()
    currentDisplayedConversationId = null;
    $('.menu-window').hide(); 

    $('#messages-window').show();
});

$('#message-remove').click(showDeleteConfirmationModal);

function startCallTimer(durationElement) {
    let seconds = 0;
    const timer = setInterval(() => {
        seconds++;
        let minutes = Math.floor(seconds / 60);
        let remainingSeconds = seconds % 60;
        let timeString = `${minutes.toString().padStart(2, '0')}:${remainingSeconds.toString().padStart(2, '0')}`;
        durationElement.text(timeString);
    }, 1000);

    return { timerId: timer, elapsedSeconds: () => seconds };
}

function stopCallTimer(timer) {
    clearInterval(timer);
}

let lastPlayedAudioId = null;

function playRandomCallSound() {
    let audioIds = ['callAudio1', 'callAudio2', 'callAudio3'];
    if (lastPlayedAudioId) {
        audioIds = audioIds.filter(id => id !== lastPlayedAudioId);
    }

    let randomIndex = Math.floor(Math.random() * audioIds.length);
    let selectedAudioId = audioIds[randomIndex];
    lastPlayedAudioId = selectedAudioId;

    setTimeout(() => {
        playSound(`#${selectedAudioId}`, 0.1);
    }, 1000);

    return $(`#${selectedAudioId}`)[0];
}

function playSound(soundId, volume = 1) {
    let audioElement = $(soundId)[0];
    audioElement.volume = volume;
    audioElement.currentTime = 0;
    audioElement.play();
}

$('#message-call').click(function() {
    var conversationId = currentDisplayedConversationId
    if (conversations[conversationId].cancelConversation) return;

    blurDiv('#message-window');
    $('#call-window').fadeIn();
    $('#call-window').css('display', 'flex');

    var callerId = translate("phone_call_stranger_title", conversationId);
    $('#call-window h2').text(callerId);
    var callDurationElement = $('#call-window p');
    callDurationElement.text('00:00');

    let callTimer = startCallTimer(callDurationElement);
    let callAudio = playRandomCallSound();

    callAudio.onended = function() {
        if (conversations[conversationId].cancelConversation) return;
        setTimeout(() => {
            $('#message-call').fadeOut();
            conversations[conversationId].call = false

            stopCallTimer(callTimer.timerId);
            $('#call-window').fadeOut();
            unblurDiv('#message-window');

            let callDuration = callTimer.elapsedSeconds();
            addMessageToConversation(conversationId, translate("phone_call_message_end", callDuration), true);

            var randomDelay = Math.floor(Math.random() * (5500 - 3000 + 1)) + 3000;
            setTimeout(() => {
                quantity = generateRandomQuantity(conversations[conversationId].playerDrugAmount)
                conversations[conversationId].npcTakeAmount = quantity
                var itemName = conversations[conversationId].itemName;
                $.post('https://nv_drugs/phoneStartTradeMission', JSON.stringify({ conversationId: conversationId, quantity: quantity, itemName: itemName }) )
                    .done(function(coords) {
                        if (coords) {
                            addMessageToConversation(conversationId, randomTranslate("phone_message_accept_offer", quantity), false);

                            setTimeout(() => {       
                                conversations[conversationId].gpsCoords = coords
                                addMessageToConversation(conversationId, randomTranslate("phone_message_gps"), false, "img/gps.png");
                            }, 2500);
                        } else if (!coords) {
                            addMessageToConversation(conversationId, randomTranslate("phone_message_no_places"), false);
                        }
                    })

            }, randomDelay);
        }, 2000); 
    };
});

function generateRandomQuantity(playerQuantity) {
    var min = phoneConfig.minQuantity;
    var max = Math.min(playerQuantity, phoneConfig.maxQuantity);

    return Math.floor(Math.random() * (max - min + 1)) + min;
}

var blurActive = false;
function blurDiv(selector) {
    blurActive = true;
    var $div = $(selector);
    var $overlay = $('<div>').addClass('blur-overlay');

    $div.css('position', 'relative').prepend($overlay);

    $div.addClass('blur-effect');
}

function unblurDiv(selector) {
    blurActive = false;
    var $div = $(selector);
    $div.find('.blur-overlay').remove(); 
    $div.removeClass('blur-effect'); 
}

function incrementNewMessagesCount() {
    var $messagesCount = $('#messages-new-amount');
    var count = parseInt($messagesCount.text()) || 0;

    count++;
    $messagesCount.text(count);

    if (count > 0) {
        $messagesCount.css('opacity', 1);
    }
}

function resetNewMessagesCount() {
    var $messagesCount = $('#messages-new-amount');

    $messagesCount.text('0');
    $messagesCount.css('opacity', 0);
}

function updateMessageSmallDataMenu(conversationId, newText) {
    var $messageToUpdate = $('#messages-container').find(`div.message[data-message-id='${conversationId}']`);
    $messageToUpdate.find('.message-data').text(shortenName(newText, 18));
}

var conversations = {};
function createMessageWithJQuery(messageId, itemName, placeIndex, quantity) {
    var itemLabel = (drugsData[itemName] && drugsData[itemName].label) ? drugsData[itemName].label : itemName;
    var text = translate("phone_message_initial_offer", quantity, itemLabel);
    
    if (!conversations[messageId]) {
        conversations[messageId] = {
            itemName: itemName,
            placeIndex: placeIndex,
            npcDrugAmount: quantity,
            playerDrugAmount: quantity, // Initialize for negotiation
            cancelConversation: false,
            unreadCount: 0,
            enterHowMuch: false, // Skip manual quantity input
            enterPrice: true,
            call: false,
            messages: []
        };
    }

    if (isPhoneVisibleForNotification || !$("#telephone-container").is(":visible") ) {
        showNotification(`Stranger #${messageId}`, text)  
    }

    if (!$("#messages-window").is(":visible")) {
        incrementNewMessagesCount()
    }

    conversations[messageId].messages.push({ fromPlayer: false, text: text });

    var $message = $('<div>', {
        class: 'message',
        'data-message-id': messageId
    });

    // Unread Badge
    var $badge = $('<div>', { class: 'unread-badge' });
    $message.append($badge);

    var $img = $('<img>', { src: 'img/person.png' });
    $message.append($img);

    var $messageTexts = $('<div>', { class: 'message-texts' });
    var $messageTitle = $('<div>', { class: 'message-title', text: translate("phone_call_stranger_title", messageId) });
    $messageTexts.append($messageTitle);

    var $messageData = $('<div>', { class: 'message-data', text: shortenName(text, 18) });
    $messageTexts.append($messageData);

    $message.append($messageTexts);

    $message.click(function() {
        var clickedMessageId = $(this).data('message-id');
        $('.menu-window').hide(); 
        $('#message-window').show();
        createCorrespondence(clickedMessageId);
    });

    $('#messages-container').prepend($message);
}

function createCorrespondence(conversationId) {
    currentDisplayedConversationId = conversationId;

    var conversation = conversations[conversationId];
    if (!conversation) {
        console.error('The conversation with the given ID does not exist:', conversationId);
        return;
    }

    // Reset Unread
    conversation.unreadCount = 0;
    var $ms = $('#messages-container').find(`div.message[data-message-id='${conversationId}']`);
    $ms.find('.unread-badge').hide();

    $('#message-items').empty();

    $('#message-nav p').text(translate("phone_call_stranger_title", conversationId));

    conversation.messages.forEach(function(message, index) {
        var messageClass = message.fromPlayer ? 'message-item message-item-reverse' : 'message-item';

        var $messageItem = $('<div>', { class: messageClass });
        var $img = $('<img>', { src: 'img/person.png' });
        var $text = $('<p>', { text: message.text });

        if (index == conversation.messages.length - 1 && conversation.gps) {
            var $image = $('<img>', { src: 'img/gps.png', class: 'message-image' });
            $text.append($image); 

            $image.click(function() {
                if (conversations[conversationId].cancelConversation) return;

                var gpsCoords = conversations[conversationId].gpsCoords;

                $.post('https://nv_drugs/setWaypoint', JSON.stringify({ coords: gpsCoords }))
            });
        }

        $messageItem.append($img).append($text);
        $('#message-items').append($messageItem);
    });


    // INPUT LOAD
    $("#message-input").empty()
    if (conversation.enterHowMuch) {
        var inputField = $("<input>", { 
            type: "number", 
            class: "message-input-field",
            placeholder: translate("phone_message_input_drug_amount"),
            min: "1",
            step: "1"
        });
        var imgAccept = $("<img>", { 
            src: "img/send.png",
            id: "imgAccept",
            click: function() {
                inputAccept('amount', inputField, conversationId, conversation)
            }
        });
        $("#message-input").append(inputField);
        $("#message-input").append(imgAccept);
    } else if (conversation.enterPrice) {
        // conversation.enterPrice = true // This line is redundant here as it should be set before createCorrespondence is called

        var inputField = $("<input>", { 
            type: "number", 
            class: "message-input-field",
            placeholder: translate("phone_message_input_price"),
            min: "1",
            step: "1"
        });

        var imgAccept = $("<img>", { 
            src: "img/send.png",
            id: "imgAccept",
            click: function() {
                inputAccept('price', inputField, conversationId, conversation)
            }
        });

        $("#message-input").append(inputField);
        $("#message-input").append(imgAccept);
    } else {
        var imgAccept = $("<img>", { 
            src: "img/send.png",
            id: "imgAccept",
        });

        $("#message-input").append(imgAccept);
    }

    if (conversation.call) {
        $("#message-call").fadeIn()
    } else if (!conversation.call) {
        $("#message-call").css("display", "none");
    }
}

function inputAccept(type, inputField, conversationId, conversation) {
    if (conversations[conversationId].cancelConversation) return;

    var inputValue = inputField.val();
    var numericValue = parseInt(inputValue);
    var valueLimit = phoneConfig.maxQuantity
    var valueMin = phoneConfig.minQuantity

    if (type == 'amount') {
        if (isNaN(numericValue) || numericValue < 1) {
            // Invalid Amount
            addMessageToConversation(conversationId, randomTranslate("phone_message_drug_amount_fail"), false); 
            inputField.val(''); // Clear input for retry
            return;
        }

        $("#imgAccept").off('click');
        inputField.remove();
        
        conversation.enterHowMuch = false;
        conversation.playerDrugAmount = numericValue
        
        addMessageToConversation(conversationId, randomTranslate("phone_message_drug_amount", numericValue), true);

        var randomDelay = Math.floor(Math.random() * (2500 - 1000 + 1)) + 1000;
        
        if (numericValue > valueLimit || numericValue < valueMin) {
            setTimeout(() => {
                addMessageToConversation(conversationId, randomTranslate("phone_message_drug_amount_fail"), false);
            }, randomDelay);
        } else {
            setTimeout(() => {
                conversation.enterPrice = true
                addMessageToConversation(conversationId, randomTranslate('phone_message_price_question'), false);

                if (currentDisplayedConversationId == conversationId) {
                    var inputField = createInput(translate("phone_message_input_price"), "number");
                    addInputToConversation(conversationId, inputField);
                }
            }, randomDelay);
        }

    } else if (type == 'price') {
        if (isNaN(numericValue) || numericValue < 1) {
            // Invalid Price - Immersive Error
            var errorMsgs = [
                "Kestu raconte gros ? Donne moi ton prix.",
                "Arrête de bégayer et donne un chiffre.",
                "C'est pas un prix ça. Sérieux ?",
                "Tu te fous de moi ? Dis un prix."
            ];
            var randomMsg = errorMsgs[Math.floor(Math.random() * errorMsgs.length)];
            
            addMessageToConversation(conversationId, randomMsg, false);
            inputField.val(''); // Clear input for retry
            return; 
        }

        $("#imgAccept").off('click');
        inputField.hide();

        conversation.enterPrice = false;
        addMessageToConversation(conversationId, randomTranslate("phone_message_price_answer", inputValue), true);

        var inputNumber = parseInt(inputValue)
        var randomDelay = Math.floor(Math.random() * (2500 - 1000 + 1)) + 1000;
        $.post('https://nv_drugs/wholesaleNegotiatePrice', JSON.stringify({ 
            conversationId: conversationId, 
            inputValue: inputNumber,
            itemName: conversation.itemName,
            quantity: conversation.playerDrugAmount
        }))
            .done(function(data) {
                if (data.result === "success") {
                    setTimeout(() => {
                        inputField.remove();
                        
                        // SKIPPING CALL SIMULATION - DIRECT MISSION START
                        // Use negotiated quantity and price
                        var quantity = conversation.playerDrugAmount; 
                        var itemName = conversation.itemName;
                        var price = inputNumber;

                        $.post('https://nv_drugs/phoneStartTradeMission', JSON.stringify({ conversationId: conversationId, quantity: quantity, itemName: itemName, price: price }) )
                            .done(function(coords) {
                                if (coords) {
                                    // NPC accepts with quantity
                                    addMessageToConversation(conversationId, randomTranslate("phone_message_accept_offer", quantity), false); 

                                    setTimeout(() => {       
                                        conversation.gpsCoords = coords
                                        addMessageToConversation(conversationId, randomTranslate("phone_message_gps"), false, "img/gps.png");
                                    }, 1500);
                                } else {
                                    addMessageToConversation(conversationId, randomTranslate("phone_message_no_places"), false);
                                }
                            })

                    }, randomDelay);
                } else if (data.result === "negotiation") {
                    setTimeout(() => {
                        conversation.enterPrice = true;
                        addMessageToConversation(conversationId, randomTranslate("phone_message_price_negotiation"), false);
                    }, randomDelay);
                } else if (data.result === "cancelPrice") {
                    setTimeout(() => {
                        addMessageToConversation(conversationId, randomTranslate("phone_message_price_fail"), false);
                    }, randomDelay);
                } else if (data.result === "cancel") { // If not police or correct respect
                    setTimeout(() => {
                        addMessageToConversation(conversationId, randomTranslate("phone_message_price_no_req"), false);
                    }, randomDelay);
                } else if (data.result === "wrongPrice") { // If you provide higher price than before negotiation
                    setTimeout(() => {
                        addMessageToConversation(conversationId, randomTranslate("phone_message_price_lower_before"), false);
                    }, randomDelay);
                }
            })

    }
}

function addMessageToConversation(conversationId, text, fromPlayer, imagePath) {
    if (!conversations[conversationId]) {
        console.error('The conversation with the given ID does not exist:', conversationId);
        return;
    }

    var newMessage = { fromPlayer: fromPlayer, text: text };
    conversations[conversationId].messages.push(newMessage);

    var smallMessage = fromPlayer ? translate("notify_input_wrong", text) : text;
    updateMessageSmallDataMenu(conversationId, smallMessage);

    if (currentDisplayedConversationId == conversationId) {
        var messageClass = fromPlayer ? 'message-item message-item-reverse' : 'message-item';
        var $messageItem = $('<div>', { class: messageClass });
        var $img = $('<img>', { src: 'img/person.png' });
        var $text = $('<p>', { text: text });

        if (imagePath) {
            var $image = $('<img>', { src: imagePath, class: 'message-image' });
            $text.append($image); 
            conversations[conversationId].gps = true

            $image.click(function() {
                if (conversations[conversationId].cancelConversation) return;
                var gpsCoords = conversations[conversationId].gpsCoords;

                $.post('https://nv_drugs/setWaypoint', JSON.stringify({ coords: gpsCoords }))
            });
        }
        
        // APPEND MESSAGE TO DOM (CRITICAL!)
        $messageItem.append($img).append($text);
        $('#message-items').append($messageItem);
        
        // Auto-Scroll
        var messageContainer = document.getElementById("message-items");
        messageContainer.scrollTop = messageContainer.scrollHeight;

        // Force Input Render if needed
         $("#message-input").empty();
         var conversation = conversations[conversationId];
         
         if (conversation.enterHowMuch) {
            var inputField = $("<input>", { 
                type: "number", 
                class: "message-input-field",
                placeholder: translate("phone_message_input_drug_amount"),
                min: "1",
                step: "1"
            });
            var imgAccept = $("<img>", { 
                src: "img/send.png",
                id: "imgAccept",
                click: function() {
                    inputAccept('amount', inputField, conversationId, conversation)
                }
            });
            $("#message-input").append(inputField).append(imgAccept);
            inputField.focus();

         } else if (conversation.enterPrice) {
            var inputField = $("<input>", { 
                type: "number", 
                class: "message-input-field",
                placeholder: translate("phone_message_input_price"),
                min: "1",
                step: "1"
            });
            var imgAccept = $("<img>", { 
                src: "img/send.png",
                id: "imgAccept",
                click: function() {
                    inputAccept('price', inputField, conversationId, conversation)
                }
            });
            $("#message-input").append(inputField).append(imgAccept);
            inputField.focus();
         }
        scrollInnerElementToBottom("#message-items");
    }

    if (isPhoneVisibleForNotification || !$("#telephone-container").is(":visible") ) {
            if (!fromPlayer) {
                // If phone is open for notification OR closed
                showNotification(translate("phone_call_stranger_title", conversationId), text)
                if (!$("#telephone-container").is(":visible")) {
                     $.post('https://nv_drugs/notifyNewMessage');
                }
                
                // Mark unread since user isn't looking at it
                 if (!conversations[conversationId].unreadCount) conversations[conversationId].unreadCount = 0;
                 conversations[conversationId].unreadCount++;
                 var $ms = $('#messages-container').find(`div.message[data-message-id='${conversationId}']`);
                 $ms.find('.unread-badge').show();
            }
    } else if (!fromPlayer) {
        // Phone is OPEN (Full UI)
        // Check if we are in this conversation
        if (currentDisplayedConversationId !== conversationId || !$("#messages-window").is(":visible")) {
             
             showNotification(translate("phone_call_stranger_title", conversationId), text);
             if (!$("#telephone-container").is(":visible")) {
                  $.post('https://nv_drugs/notifyNewMessage');
             }
             
             if (!conversations[conversationId].unreadCount) conversations[conversationId].unreadCount = 0;
             conversations[conversationId].unreadCount++;
             
             var $ms = $('#messages-container').find(`div.message[data-message-id='${conversationId}']`);
             $ms.find('.unread-badge').show();

             if (!$("#messages-window").is(":visible")) {
                 incrementNewMessagesCount()
             }
        }
    }
}

function scrollInnerElementToBottom(selector) {
    var element = $(selector);
    element.animate({
        scrollTop: element.prop('scrollHeight')
    }, 1000);
}

var lastNotificationSwitchTime = 0;
var lastSoundSwitchTime = 0;

function canChangeSwitch(lastChangeTime) {
    var currentTime = Date.now();
    if (currentTime - lastChangeTime < 5000) {
        Notify(translate("notify_settings_error"), "error", 2500)
        return false;
    }
    return true;
}

$('#notificationSwitch').change(function() {
    if (canChangeSwitch(lastNotificationSwitchTime)) {
        lastNotificationSwitchTime = Date.now();

        if (!this.checked) {
            notificationQueue = [];
        }

        var statusAlerts = $(this).prop('checked');
        var statusAlertsSound = $('#soundSwitch').prop('checked');

        $.post('https://nv_drugs/saveSettings', JSON.stringify({ statusAlerts: statusAlerts, statusAlertsSound: statusAlertsSound }));
    } else {
        $(this).prop('checked', !$(this).prop('checked'));
    }
});

$('#soundSwitch').change(function() {
    if (canChangeSwitch(lastSoundSwitchTime)) {
        lastSoundSwitchTime = Date.now();

        var statusAlerts = $('#notificationSwitch').prop('checked');
        var statusAlertsSound = $(this).prop('checked');

        $.post('https://nv_drugs/saveSettings', JSON.stringify({ statusAlerts: statusAlerts, statusAlertsSound: statusAlertsSound }));
    } else {
        $(this).prop('checked', !$(this).prop('checked'));
    }
});

var lastSellingSwitchTime = 0;
$('#sellingSwitch').change(function() {
    if (canChangeSwitch(lastSellingSwitchTime)) {
        lastSellingSwitchTime = Date.now();
        var status = $(this).prop('checked');
        $.post('https://nv_drugs/toggleSelling', JSON.stringify({ status: status }));
        
        if (status) {
            checkAndGenerateDeal(true);
        }
    } else {
        $(this).prop('checked', !$(this).prop('checked'));
    }
});

// ... (omitted)

// Deal Generator
var dealInterval = null;
var drugsList = [];
var drugsData = {};

function startDealGenerator() {
    if (dealInterval) clearInterval(dealInterval);
    
    // Immediate check forced
    checkAndGenerateDeal(true);

    // Check interval from config or default 60s
    var intervalTime = (phoneConfig && phoneConfig.MessageInterval) ? (phoneConfig.MessageInterval * 1000) : 60000;
    dealInterval = setInterval(checkAndGenerateDeal, intervalTime); 
}

function checkAndGenerateDeal(force) {
    // Check if selling mode is active
    if (!drugsData || drugsList.length === 0) return;
    if (!$('#sellingSwitch').is(':checked')) return;

    // 50% chance to get a message UNLESS forced
    if (force || Math.random() < 0.5) {
        var randomDrug = drugsList[Math.floor(Math.random() * drugsList.length)];
        var randomId = Math.floor(Math.random() * 9000) + 1000;
        
        if (!conversations[randomId]) {
             var min = (phoneConfig && phoneConfig.MinQuantity) ? phoneConfig.MinQuantity : 15;
             var max = (phoneConfig && phoneConfig.MaxQuantity) ? phoneConfig.MaxQuantity : 20;
             var quantity = Math.floor(Math.random() * (max - min + 1)) + min;
             
             createMessageWithJQuery(randomId, randomDrug, 0, quantity); 
        }
    }
}

function loadPlayerSettings(settings) {
    if(settings.statusAlerts !== undefined) {
        $('#notificationSwitch').prop('checked', settings.statusAlerts);
    }

    if(settings.statusAlertsSound !== undefined) {
        $('#soundSwitch').prop('checked', settings.statusAlertsSound);
    }
    
    if(settings.sellingMode !== undefined) {
        $('#sellingSwitch').prop('checked', settings.sellingMode);
    }
}


var notificationQueue = [];
var isNotificationShowing = false;

function showNotification(title, message) {
    if (!$('#notificationSwitch').is(':checked')) {
        return; 
    }

    notificationQueue.push(function() {
        if (!$("#telephone-container").is(":visible")) {
            togglePhoneForNotification();
        }



        isNotificationShowing = true;

        // Cleanup any stuck alerts
        $("#telephone-background").find("#telephone-alert").remove();

        var $notification = $('<div id="telephone-alert">' +
                              '<div id="alert-title">' +
                              '<img src="img/messages.png">' +
                              '<h2>' + title + '</h2>' +
                              '</div>' +
                              '<p>' + message + '</p>' +
                              '</div>');

        $("#telephone-background").prepend($notification);
        $notification.css('top', '-5.5vh');

        if ($('#soundSwitch').is(':checked')) {
            playSound("#notification", 0.1);
        }

        $notification.animate({ top: '1vh' }, 500, function() {
            setTimeout(function() {
                $notification.animate({ top: '-5.5vh' }, 500, function() {
                    $notification.remove();
                    isNotificationShowing = false;
                    checkQueue();
                });
            }, 3000);
        });
    });

    checkQueue();
}

function checkQueue() {
    if (notificationQueue.length > 0 && !isNotificationShowing) {
        (notificationQueue.shift())();
    } else if (notificationQueue.length === 0 && isPhoneVisibleForNotification) {
        $("#telephone-container").stop().animate({
            bottom: '-60%'
        }, 1000, function() {
            $(this).css('display', 'none');
            isPhoneVisibleForNotification = false; // Fix: Reset state
        });
    }
}

function togglePhoneForNotification() {
    isPhoneVisibleForNotification = true;
    $("#telephone-container").stop().css('display', 'block').animate({
        bottom: '-45%'
    }, 500);
}

function loadPlayerExperiencePhone(data) {
    var respectPercentage = (data.respect / data.respectLimit) * 100;
    $('#app-progress-respect').css('width', respectPercentage + '%');
    $('#app-progress-respect').next('p').text(data.respect + ' / ' + data.respectLimit);

    var salesPercentage = (data.saleSkill / data.salesLimit) * 100;
    $('#app-progress-selling').css('width', salesPercentage + '%');
    $('#app-progress-selling').next('p').text(data.saleSkill + ' / ' + data.salesLimit);
}

// MOLE

var moleConversations = {};
function createConversationMole(moleName, text) {
    if (!moleConversations[moleName]) {
        moleConversations[moleName] = {
            messages: []
        };
    }

    if (isPhoneVisibleForNotification || !$("#telephone-container").is(":visible") ) {
        showNotification(moleName, text)  
    }

    if (!$("#messages-window").is(":visible")) {
        incrementNewMessagesCount()
    }

    moleConversations[moleName].messages.push({ fromPlayer: false, text: text });

    var $message = $('<div>', {
        class: 'message',
        'data-message-id': moleName
    });

    var $img = $('<img>', { src: 'img/person.png' });
    $message.append($img);

    var $messageTexts = $('<div>', { class: 'message-texts' });
    var $messageTitle = $('<div>', { class: 'message-title', text: moleName });
    $messageTexts.append($messageTitle);

    var $messageData = $('<div>', { class: 'message-data', text: shortenName(text, 18) });
    $messageTexts.append($messageData);

    $message.append($messageTexts);

    $message.click(function() {
        var moleNameID = $(this).data('message-id');
        $('.menu-window').hide(); 
        $('#message-window').show();
        createMoleCorrespondence(moleNameID);
    });

    $('#messages-container').prepend($message);
}

function createMoleCorrespondence(moleName) {
    currentDisplayedConversationId = moleName;
    var conversation = moleConversations[moleName];
    if (!conversation) {
        console.error('The conversation with the given ID does not exist:', moleName);
        return;
    }

    $('#message-items').empty();

    $('#message-nav p').text(moleName);

    conversation.messages.forEach(function(message, index) {
        var messageClass = message.fromPlayer ? 'message-item message-item-reverse' : 'message-item';

        var $messageItem = $('<div>', { class: messageClass });
        var $img = $('<img>', { src: 'img/person.png' });
        var $text = $('<p>', { text: message.text });

        $messageItem.append($img).append($text);
        $('#message-items').append($messageItem);
    });


    // INPUT LOAD
    $("#message-input").empty()

    var imgAccept = $("<img>", { 
        src: "img/send.png",
        id: "imgAccept",
    });

    $("#message-input").append(imgAccept);

    $("#message-call").css("display", "none");
}

function addMessageToConversationMole(moleName, text, fromPlayer) {
    if (!moleConversations[moleName]) {
        createConversationMole(moleName, text);
        return;
    }

    var newMessage = { fromPlayer: fromPlayer, text: text };
    moleConversations[moleName].messages.push(newMessage);

    var smallMessage = fromPlayer ? `You: ${text}` : text;
    updateMessageSmallDataMenu(moleName, smallMessage);

    if (currentDisplayedConversationId === moleName) {
        var messageClass = fromPlayer ? 'message-item message-item-reverse' : 'message-item';
        var $messageItem = $('<div>', { class: messageClass });
        var $img = $('<img>', { src: 'img/person.png' });
        var $text = $('<p>', { text: text });

        $messageItem.append($img).append($text);
        $('#message-items').append($messageItem);

        scrollInnerElementToBottom("#message-items");

        if (isPhoneVisibleForNotification || !$("#telephone-container").is(":visible") ) {
            if (!fromPlayer) {
                showNotification(moleName, text)  
            }
        } else if (!fromPlayer) {
            showNotification(moleName, text)

            if (!$("#messages-window").is(":visible")) {
                incrementNewMessagesCount()
            }
        }
    }
}

// Deal Generator
var dealInterval = null;
var drugsList = [];
var drugsData = {};

function startDealGenerator() {
    if (dealInterval) clearInterval(dealInterval);
    
    // Immediate check
    checkAndGenerateDeal(true);

    // Check every 60 seconds
    dealInterval = setInterval(checkAndGenerateDeal, 60000); 
}

function checkAndGenerateDeal(force) {
    // Check if selling mode is active
    if (!drugsData || drugsList.length === 0) return;
    if (!$('#sellingSwitch').is(':checked')) return;

    // 50% chance to get a message
    if (force || Math.random() < 0.5) {
        var randomDrug = drugsList[Math.floor(Math.random() * drugsList.length)];
        var randomId = Math.floor(Math.random() * 9000) + 1000;
        var conversationId = "Stranger #" + randomId; 
        
        if (!conversations[randomId]) {
             var min = phoneConfig.MinQuantity || 15;
             var max = phoneConfig.MaxQuantity || 20;
             var quantity = Math.floor(Math.random() * (max - min + 1)) + min;
             
             createMessageWithJQuery(randomId, randomDrug, 0, quantity); 
        }
    }
}

window.addEventListener('message', function(event) {
    var data = event.data;

    if (data.action === "togglePhoneNUI") {
        if (data.showNUI) {
            togglePhoneUI(true, true);
            // Translate is handled separately via data.translations usually, checking below
        } else {
            togglePhoneUI(false, true);
        }

        if (data.playerExperience) {
            loadPlayerExperiencePhone(data.playerExperience);
        }

        if (data.settings) {
            loadPlayerSettings(data.settings);
        }

        if (data.config) {
            phoneConfig = data.config;
        }
        
        if (data.drugs) {
            drugsData = data.drugs;
            drugsList = Object.keys(data.drugs);
            startDealGenerator();
        }

        if (data.translations) {
            translations = data.translations;
        }
    }
});