$("#new_diploma").validate({
  rules: {
    "diploma[certification]": {
      required: true,
      minlength: 10
    }, 
    "diploma[demonstrate]": {
      required: true
    }
  },
  messages: {
    "diploma[certification]": {
        required: I18n.t("views.requests.new.valid.required"),
        minlength: I18n.t("views.requests.new.valid.header_length")
      },
    "diploma[demonstrate]": {
      required: I18n.t("views.requests.new.valid.required")
    }
  }
});
