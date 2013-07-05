 $(function() {
    $( "#datepicker" ).datepicker( { dateFormat: "dd-mm-yy", minDate:"-70y", maxDate:"+0d",  changeMonth: true, changeYear: true } );
   	$( "#datepicker_future" ).datepicker( { dateFormat: "dd-mm-yy", minDate:"+0d", maxDate:"+1y",  changeMonth: true, changeYear: true } );
  });
 