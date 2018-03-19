jQuery.validator.addMethod("bill", function(value, element){
  if (/^(?!-)([1-9]+(\.\d+)?)/.test(value)) {
    return true;
  } else {
    return false;
  };
}, I18n.t("views.requests.new.valid.wrong-format"));
$("#new_request").validate({
  rules: {
    "request[header]": {
      required: true,
      minlength: 10
    },
    "request[content]": {
      required: true,
      minlength: 20
    },
    "request[bill]": {
      required: true,
      bill: true
    }
  },
  messages: {
    "request[header]": {
      required: I18n.t("views.requests.new.valid.required"),
        minlength: I18n.t("views.requests.new.valid.header_length")
      },
    "request[content]": {
      required: I18n.t("views.requests.new.valid.required"),
        minlength: I18n.t("views.requests.new.valid.content_length")
      },
    "request[bill]": {
      required: I18n.t("views.requests.new.valid.required")
    }
  }
});
