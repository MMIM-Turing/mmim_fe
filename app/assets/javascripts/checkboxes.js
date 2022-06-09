   function checkboxtic() {
       $(':obj').on('change', function () {
           $('input[type="submit"]').prop('disabled', !$(':checkbox:checked').length);
       }).change();