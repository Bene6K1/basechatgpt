function Notify(text, type, duration) {
    $.post('https://is_selldrugs/notification', JSON.stringify({ text: text, type: type, duration: duration }));
}