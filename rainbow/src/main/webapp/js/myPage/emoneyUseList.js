/**
 * 
 */
function changeQuickDate(date,formId){
   var schSdate = getQuickDate(date);
   var schEdate = getQuickDate('day');
   $("input[name=sch_sdate]").val(schSdate);
   $("input[name=sch_edate]").val(schEdate);
   searchFormSubmit(formId);
}