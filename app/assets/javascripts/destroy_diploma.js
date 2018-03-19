$(function(){
  delete_diploma = function(diploma){
    var diploma_id = diploma.id;
    var confirm_del = confirm(I18n.t("views.diplomas.modal_form.confirm"));
    if (confirm_del) {
      $.ajax({
        method: 'DELETE',
        url: '/diplomas/' + diploma_id
      }).success(function(data){
        if (data.status == "success"){
          $('.diploma-' + diploma_id).remove();
        } else {
          alert(I18n.t("views.diplomas.modal_form.destroy_fail"));
        }
      }).error(function(){
        alert(I18n.t("views.diplomas.modal_form.destroy_fail"));
      });
    }
  }
})
