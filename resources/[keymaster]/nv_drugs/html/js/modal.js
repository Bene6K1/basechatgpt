function showModal(title, content) {
    $('#modal h2').text(title);
    $('#modal p').text(content);

    $('#modal').fadeIn();

    $('#modal-button-accept').off('click').on('click', function() {
        handleUserChoice(true);
    });

    $('#modal-button-cancel').off('click').on('click', function() {
        handleUserChoice(false);
    });
}

function handleUserChoice(choice) {
    $('#modal').fadeOut();
    $.post('https://nv_drugs/modalChoice', JSON.stringify(choice));
}

function showDeleteConfirmationModal() {
    blurDiv('#message-window');

    showModal(translate('modal_delete_title'), translate('modal_delete_confirm'));

    $('#modal-button-accept').off('click').on('click', function() {
        if (currentDisplayedConversationId !== undefined) {
            $.post('https://nv_drugs/playerDeletedConversation', JSON.stringify(currentDisplayedConversationId));

            $(`[data-message-id="${currentDisplayedConversationId}"]`).remove();
            delete conversations[currentDisplayedConversationId];
            currentDisplayedConversationId = undefined;
        }
        
        unblurDiv('#message-window');

        $('#messages-window').show();
        $('.message-window').hide(); 
        $('#modal').fadeOut();
    });

    $('#modal-button-cancel').off('click').on('click', function() {
        unblurDiv('#message-window');

        $('#modal').fadeOut();
    });
}