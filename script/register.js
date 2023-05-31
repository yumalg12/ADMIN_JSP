
function falseCSS(name) {
	var element = document.Registerform[name];
	element.classList.remove("normal");
	element.classList.remove("done");
	element.classList.add("false");
}

function doneCSS(id) {
	var element = document.Registerform[id];
	element.classList.remove("normal");
	element.classList.remove("false");
	element.classList.add("done");
}

function checkID(uID) {
	var regex = /^(?=.*[!@#$%^&*()-_=+\\|[\]{};:'",.<>/?])(?=.*[a-z0-9]).{5,8}$/;

	if (regex.test(uID)) {
		doneCSS("userID");
		document.getElementById("IDnotice").style.display = "none";
		document.getElementById("checkIDdup").style.display = "";
	} else {
		falseCSS("userID");
		document.getElementById("IDnotice").style.display = "";
		document.getElementById("checkIDdup").style.display = "none";
	}
}


function checkPW() {
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


function checkName(name) {
	var regex = /^[가-힣]{2,5}$/;
	
	if(regex.test(name)){
		doneCSS("userName");
		return true;
	} else {
		falseCSS("userName");
		return false;
	}
}


function phoneInput() {
	if (document.getElementsByName("num_1")[0].value == "input") {
		document.getElementsByName("num_1")[0].style.display = "none";
		document.getElementsByName("num_1")[1].style.display = "";
	} else {
		document.getElementsByName("num_1")[0].style.display = "";
		document.getElementsByName("num_1")[1].style.display = "none";
	}
}

function emailInput() {
	if (document.getElementsByName("email_2")[0].value == "input") {
		document.getElementsByName("email_2")[0].style.display = "none";
		document.getElementsByName("email_2")[1].style.display = "";
	} else {
		document.getElementsByName("email_2")[0].style.display = "";
		document.getElementsByName("email_2")[1].style.display = "none";
	}
}

function validateForm() {
	//id check
	var uID = document.Registerform.userID.value;
	var id_len = uID.length;

	if (id_len >= 5 && id_len <= 8) {

		//pw check
		if (checkPW()) {

			// name check
			if (checkName()) {

				//gender check
				if (document.Registerform.gender.value != '') {

					//birth check
					if (checkbirth()) {

						//Phone number check
						if (checkPhone()){
							
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
		alert("ID는 영문, 숫자, 특수문자로 이루어진 5~8자여야 합니다.");
		setTimeout(function() { (document.Registerform.userID).focus(); }, 100);
		return false;
	}

}
