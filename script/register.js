
function falseCSS(name) {
	var element = document.Registerform[name];
	element.classList.remove("normal");
	element.classList.remove("done");
	element.classList.add("false");
}

function doneCSS(name) {
	var element = document.Registerform[name];
	element.classList.remove("normal");
	element.classList.remove("false");
	element.classList.add("done");
}

function checkID(uID) {
	var regex = /^[a-z0-9]{5,8}$/;

	if (regex.test(uID)) {
		doneCSS("userID");
		document.getElementById("IDNotice").style.display = "none";
		return true;
	} else {
		falseCSS("userID");
		document.getElementById("IDNotice").style.display = "";
		return false;
	}
}	

function checkPWone() {	
	var regex = /^[a-zA-Z0-9!@#$%^&*()-_=+\\|[\]{};:'",.<>/?]{4,20}$/;

	var PWone = document.Registerform.PW.value;

	if (regex.test(PWone)){
		doneCSS("PW");
		document.getElementById("PWNotice").style.display = "none";
		document.getElementsByName("PWcheck")[0].style.display = "";
		return true;
	} else {
		falseCSS("PW");
		document.getElementById("PWNotice").style.display = "";
		document.getElementsByName("PWcheck")[0].style.display = "none";	
		return false;	
	}
}

function checkPWtwo() {	
	var PWone = document.Registerform.PW.value;
	var PWtwo = document.Registerform.PWcheck.value;
	
	if (PWone != PWtwo) {
		falseCSS("PWcheck");
		return false;
	} else {
		doneCSS("PWcheck");
		return true;
	}
}


function checkName() {
	var len = (document.getElementsByName("userName")[0].value).length;
	
	if(len >= 2){
		doneCSS("userName");
		document.getElementById("nameNotice").style.display = "none";
		return true;
	} else {
		falseCSS("userName");
		document.getElementById("nameNotice").style.display = "";
		return false;
	}
}

function checkBirth(){
  var currentDate = new Date();
  currentDate.setHours(0, 0, 0, 0);
  var birthDateInput = document.getElementsByName("birthDate")[0].value;
  var [year, month, day] = birthDateInput.split('-').map(Number);
  var birthDate = new Date(year, month - 1, day + 3);

  var age = (currentDate - birthDate) / (1000 * 60 * 60 * 24 * 365);
  
	if (age < 14) {
		falseCSS("birthDate");
		document.getElementById("ageNotice").style.display = "";
		return false;
	} else {
		doneCSS("birthDate");
		document.getElementById("ageNotice").style.display = "none";
		return true;
	}
}


function phoneInput() {
	if (document.getElementsByName("num1")[0].value == "input") {
		document.getElementsByName("num1")[0].style.display = "none";
		document.getElementsByName("num1")[1].style.display = "";
	} else {
		document.getElementsByName("num1")[0].style.display = "";
		document.getElementsByName("num1")[1].style.display = "none";
	}
}

function checkPhoneOne(){
	var regex = /^[0][1-9][0-9]$/;

	if (regex.test(document.getElementsByName("num1")[0].value) || regex.test(document.getElementsByName("num1")[1].value)) {
		var element = document.Registerform["num1"][1];
		element.classList.remove("normal");
		element.classList.remove("false");
		element.classList.add("done");
		return true;
	} else {
		var element = document.Registerform["num1"][1];
		element.classList.remove("normal");
		element.classList.remove("done");
		element.classList.add("false");
		return false;
	}
}

function checkPhone(name){
	var regex = /^[0-9]{3,4}$/;

	if(regex.test(document.getElementsByName(name)[0].value)) {
		doneCSS(name);
		return true;
	} else {
		falseCSS(name);
		return false;
	}
}


function emailInput() {
	if (document.getElementsByName("email2")[0].value == "input") {
		document.getElementsByName("email2")[0].style.display = "none";
		document.getElementsByName("email2")[1].style.display = "";
	} else {
		document.getElementsByName("email2")[0].style.display = "";
		document.getElementsByName("email2")[1].style.display = "none";
	}
}

function checkMail() {
	var len = (document.getElementsByName("email1")[0].value).length;
	
	if(len >= 1){
		doneCSS("email1");
		return true;
	} else {
		falseCSS("email1");
		return false;
	}
}


function validateForm() {
	//id check
	var uID = document.Registerform.userID.value;

	if (checkID(uID)) {
		
		//pw check
		if (checkPW()) {

			// name check
			if (checkName()) {

				//gender check
				if (document.Registerform.gender.value != '') {

					//birth check
					if (checkBirth()) {

						//Phone number check
						if (checkPhoneOne() && checkPhone(num2) && checkPhone(num3)){
							
							//email check
							if(checkMail()){
								
								// address check
								if (checkAddress()){
									
									return true;
									
								} else {
									alert("올바른 주소를 입력하십시오.");
									setTimeout(function() {
										var elements = document.getElementsByClassName("false");
										if (elements.length > 0) {
											elements[0].focus();
										}
									}, 100);
								}
								
							} else {
								alert("올바른 이메일 주소를 입력하십시오.");
								setTimeout(function() {
									var elements = document.getElementsByClassName("false");
									if (elements.length > 0) {
										elements[0].focus();
									}
								}, 100);
							}
							
						} else {
							alert("올바른 전화번호를 입력하십시오.");
							setTimeout(function() {
								var elements = document.getElementsByClassName("false");
								if (elements.length > 0) {
									elements[0].focus();
								}
							}, 100);
						}

					} else {
						alert("올바른 생년월일을 입력하십시오.");
						setTimeout(function() { (document.Registerform.birthDate).focus(); }, 100);
						return false;
					}

				} else {
					alert("올바른 이름을 입력하십시오.");
					setTimeout(function() { (document.Registerform.userName).focus(); }, 100);
					return false;
				}

			} else {
				alert("성별을 선택하십시오.");
				return false;
			}

		} else {
			alert("패스워드 확인 란을 다시 입력하십시오.");
			setTimeout(function() { (document.Registerform.PWcheck).focus(); }, 100);
			return false;
		}

	} else {
		alert("ID를 다시 입력하십시오.");
		setTimeout(function() { (document.Registerform.userID).focus(); }, 100);
		return false;
	}

}
