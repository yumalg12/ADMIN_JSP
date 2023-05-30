
function falseCSS(id) {
	var element = document.Registerform[id];
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
	} else {
		falseCSS("userID");
		document.getElementById("IDnotice").style.display = "";
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

function checkSSNfirst() {
	var ssn = document.Registerform.ssnFirst.value;
	var birthMon = document.Registerform.month.value;
	var regex = /^[0-9]{2}[0-1][1-9][0-3][0-9]$/;

	if (regex.test(ssn) && (ssn.substring(2, 4) == birthMon) && (parseInt(ssn.substring(4, 7)) <= 31)) {
		doneCSS("ssnFirst");
		return true;
	} else {
		falseCSS("ssnFirst");
		return false;
	}
}

function checkSSNlast() {
	var ssn = document.Registerform.ssnLast.value;
	var regex = /^[0-9]{7}$/;

	if (regex.test(ssn) && SSNgender()) {
		doneCSS("ssnLast");
		return true;
	} else {
		falseCSS("ssnLast");
		return false;
	}
}

function SSNgender() {
	var ssnYear = parseInt((document.Registerform.ssnFirst.value).substring(0, 1));
	var ssnGender = (document.Registerform.ssnLast.value).substring(0, 1);
	var gender = document.Registerform.gender.value;


	if (gender == "male" && ssnYear > 2) {
		if (ssnGender == "1") {
			return true;
		}
	} else if (gender == "female" && ssnYear > 2) {
		if (ssnGender == "2") {
			return true;
		}
	} else if (gender == "male") {
		if (ssnGender == "3") {
			return true;
		}
	} else if (gender == "female") {
		if (ssnGender == "4") {
			return true;
		}
	}
	return false;
}

function validateForm() {
	//id check
	var uID = document.Registerform.userID.value;
	var id_len = uID.length;

	if (id_len >= 5 && id_len <= 8) {

		//pw check
		if (checkPW()) {

			//gender check
			if (document.Registerform.gender.value != '') {
				
				//SSN check
				ssnFirst = document.Registerform.ssnFirst.value;
				ssnLast = document.Registerform.ssnLast.value;
				if (checkSSNfirst(ssnFirst) && checkSSNlast(ssnLast)) {
					return true;
				} else {
					alert("올바른 주민등록번호를 입력하십시오.");
					setTimeout(function() {
						var elements = document.getElementsByClassName("false");
						if (elements.length > 0) {
							elements[0].focus();
						}
					}, 100);
					return false;
				}
			} else {
				alert("성별을 선택하십시오.");
				return false;
			}

		} else {
			alert("패스워드 확인 란을 다시 입력하십시오.");
			setTimeout(function(){(document.Registerform.PWcheck).focus();},100);
			return false;
		}

	} else {
		alert("ID는 영문, 숫자, 특수문자로 이루어진 5~8자여야 합니다.");
		setTimeout(function(){(document.Registerform.userID).focus();},100);
		return false;
	}

}