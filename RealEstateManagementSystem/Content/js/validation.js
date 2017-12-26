var Page_DomValidationVer = "2";
var Page_IsValid = true;
var Page_BlockSubmit = false;

function ValidatorUpdateDisplay(val) {
    if (typeof (val.display) == "string") {
        if (val.display == "None") {
            return;
        }
        if (val.display == "Dynamic") {
            val.style.display = val.isvalid ? "none" : "inline";
            return;
        }
    }
    val.style.visibility = val.isvalid ? "hidden" : "visible";
}

function ValidatorUpdateIsValid() {
    var i;
    for (i = 0; i < Page_Validators.length; i++) {
        if (!Page_Validators[i].isvalid) {
            Page_IsValid = false;
            return;
        }
    }
    Page_IsValid = true;
}

function ValidatorHookupControl(control, val) {
    if (typeof (control.Validators) == "undefined") {
        control.Validators = new Array;
        var ev = control.onchange;
        var func = new Function("ValidatorOnChange('" + control.id + "');");
        control.onchange = func;
    }
    control.Validators[control.Validators.length] = val;
}

function ValidatorGetValue(id) {
    var control;
    control = document.getElementById(id);
    if (typeof (control.value) == "string") {
        return control.value;
    }
    if (typeof (control.tagName) == "undefined" && typeof (control.length) == "number") {
        var j;
        for (j = 0; j < control.length; j++) {
            var inner = control[j];
            if (typeof (inner.value) == "string" && (inner.type != "radio" || inner.status == true)) {
                return inner.value;
            }
        }
    }
    return "";
}

function Page_ClientValidate() {
    var i;
    for (i = 0; i < Page_Validators.length; i++) {
        ValidatorValidate(Page_Validators[i]);
    }
    ValidatorUpdateIsValid();
    Page_BlockSubmit = !Page_IsValid;
    return Page_IsValid;
}

function ValidatorCommonOnSubmit() {
    var returnValue = !Page_BlockSubmit;
    Page_BlockSubmit = false;
    return returnValue;
}

function ValidatorOnChange(controlID) {
    var cont = document.getElementById(controlID);
    var vals = cont.Validators;
    var i;
    for (i = 0; i < vals.length; i++) {
        ValidatorValidate(vals[i]);
    }
    ValidatorUpdateIsValid();
}

function ValidatorValidate(val) {
    val.isvalid = true;
    if (typeof (val.evalfunc) == "function") {
        val.isvalid = val.evalfunc(val);
    }
    ValidatorUpdateDisplay(val);
}

function ValidatorOnLoad() {
    if (typeof (Page_Validators) == "undefined")
        return;

    var i, val;
    for (i = 0; i < Page_Validators.length; i++) {
        val = Page_Validators[i];
        var evalFunction = val.getAttribute("evaluationfunction");
        if (typeof (evalFunction) == "string") {
            eval("val.evalfunc = " + evalFunction + ";");
        }
        var isValidAttribute = val.getAttribute("isvalid");
        if (typeof (isValidAttribute) == "string") {
            if (isValidAttribute == "False") {
                val.isvalid = false;
                Page_IsValid = false;
            }
            else {
                val.isvalid = true;
            }
        } else {
            val.isvalid = true;
        }
        var controlToValidate = val.getAttribute("controltovalidate");
        if (typeof (controlToValidate) == "string") {
            ValidatorHookupControl(document.getElementById(controlToValidate), val);
        }
    }
    Page_ValidationActive = true;
}

function RegularExpressionValidatorEvaluateIsValid(val) {
    var value = ValidatorGetValue(val.getAttribute("controltovalidate"));
    if (value == "")
        return true;
    var rx = new RegExp(val.getAttribute("validationexpression"));
    var matches = rx.exec(value);
    return (matches != null && value == matches[0]);
}

function ValidatorTrim(s) {
    var m = s.match(/^\s*(.*\S)\s*$/);
    return (m == null) ? "" : m[1];
}

function RequiredFieldValidatorEvaluateIsValid(val) {
    return (ValidatorTrim(ValidatorGetValue(val.getAttribute("controltovalidate"))) != ValidatorTrim(val.getAttribute("initialvalue")));
}