document.addEventListener("DOMContentLoaded", function() {
  var alcoholFromSelect = document.getElementById('alcohol_from');
  var alcoholToInput = document.getElementById('alcohol_to');

  alcoholFromSelect.addEventListener('change', function() {
    var selectedValue = alcoholFromSelect.value;
    
    switch (selectedValue) {
      case '0':
        alcoholToInput.value = '5';
        break;
      case '4':
        alcoholToInput.value = '15';
        break;
      case '15':
        alcoholToInput.value = '30';
        break;
      case '30':
        alcoholToInput.value = '100';
        break;
      default:
        alcoholToInput.value = '';
    }
  });
});
