$(function () {
    $('#theme-select2').on('change', function () {
        var themeText = $('#theme-select2 option:selected').text();
        $('body').removeClass();
        $('body').addClass(themeText);
    });

    function changeImage(input) {

        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('.game-image').css('background-image', 'url(' + e.target.result + ')');
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#game_image").change(function () {
        changeImage(this);
    });
});