$(document).ready(function() {
  $('#start-datetimepicker').datetimepicker({
    format: "DD/MM/YYYY hh:mm A"
  });
  $('#finish-datetimepicker').datetimepicker({
    useCurrent: false, //Important! See issue #1075
    format: "DD/MM/YYYY hh:mm A"
  });
  $("#start-datetimepicker").on("dp.change", function (e) {
    $('#finish-datetimepicker').data("DateTimePicker").minDate(e.date);
  });
  $("#finish-datetimepicker").on("dp.change", function (e) {
    $('#start-datetimepicker').data("DateTimePicker").maxDate(e.date);
  });
});
