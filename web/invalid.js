function reqValid(){
	isValidIns();
}
function isValidR(){
	let R = Number(document.getElementById("ras").value);
	if (isNaN(R) || document.getElementById("ras").value.length == 0) {
		return false;
	} else {
		if (R < 2 || R > 5) {
			return false;
		} else {
			return true;
		}
	}
}

function isValidIns(){

			if (document.getElementById("posY").value.search(",") != -1) {
				let tmp = document.getElementById("posY").value.replace(",", ".");
				document.getElementById("posY").value = tmp;
			}
			if (document.getElementById("posX").value.search(",") != -1) {
				let tmp = document.getElementById("posX").value.replace(",", ".");
				document.getElementById("posX").value = tmp;
			}
			//проверяем валидность введенных данных
			let Y = Number(document.getElementById("posY").value);
			let X = Number(document.getElementById("posX").value);
			let R = Number(document.getElementById("ras").value);
			let valid = true;
			//"bad_data"
			//box_X
			//box_Y
			//box_R
			if (isNaN(Y) || document.getElementById("posY").value.length == 0) {
				if (!document.getElementById("box_Y").classList.contains("bad_data")) document.getElementById("box_Y").classList.add("bad_data");
				//alert("Число Y должно быть в диапазоне от -3 до 5");
				valid = false;
			} else {
				if (Y < -3 || Y > 3) {
					if (!document.getElementById("box_Y").classList.contains("bad_data")) document.getElementById("box_Y").classList.add("bad_data");
					valid = false;
				} else {
					if (document.getElementById("box_Y").classList.contains("bad_data")) document.getElementById("box_Y").classList.remove("bad_data");
				}
			}

			if (isNaN(R) || document.getElementById("ras").value.length == 0) {
				if (!document.getElementById("box_R").classList.contains("bad_data")) document.getElementById("box_R").classList.add("bad_data");
				//alert("Число Y должно быть в диапазоне от -3 до 5");
				valid = false;
			} else {
				if (R < 2 || R > 5) {
					if (!document.getElementById("box_R").classList.contains("bad_data")) document.getElementById("box_R").classList.add("bad_data");
					valid = false;
				} else {
					if (document.getElementById("box_R").classList.contains("bad_data")) document.getElementById("box_R").classList.remove("bad_data");
				}
			}

			if (isNaN(X) || document.getElementById("posX").value.length == 0) {
				if (!document.getElementById("box_X").classList.contains("bad_data")) document.getElementById("box_X").classList.add("bad_data");
				//alert("Число Y должно быть в диапазоне от -3 до 5");
				valid = false;
			} else {
				if (X < -4 || X > 4) {
					if (!document.getElementById("box_X").classList.contains("bad_data")) document.getElementById("box_X").classList.add("bad_data");
					valid = false;
				} else {
					if (document.getElementById("box_X").classList.contains("bad_data")) document.getElementById("box_X").classList.remove("bad_data");
				}
			}
			if (!valid) {
				//alert("Некоторые данные введены неверно");
				document.getElementById("sbutk").disabled = true;
			} else {
				document.getElementById("sbutk").disabled = false;
			}
			return valid;
}

