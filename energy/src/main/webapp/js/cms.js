


Date.prototype.yyyymmdd = function(delimeter) {
	var yyyy = this.getFullYear().toString();
	var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based
	var dd = this.getDate().toString();

	return yyyy + isUndefined(delimeter, '') + (mm[1] ? mm : "0" + mm[0])
			+ isUndefined(delimeter, '') + (dd[1] ? dd : "0" + dd[0]);
};

Date.prototype.yyyymm = function(delimeter) {
	var yyyy = this.getFullYear().toString();
	var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based

	return yyyy + isUndefined(delimeter, '') + (mm[1] ? mm : "0" + mm[0]);
};

Date.prototype.getYYYYMMDDHHMISS = function( delimeter ) {
	var yyyy = this.getFullYear().toString();
	var mm = ( this.getMonth() + 1 ).toString(); // getMonth() is zero-based
	var dd = this.getDate().toString();
	var hh = this.getHours().toString();
	var mi = this.getMinutes().toString();
	var ss = this.getSeconds().toString();

	return yyyy + isUndefined(delimeter, '') + (mm[1] ? mm : "0" + mm[0])
			+ isUndefined(delimeter, '') + (dd[1] ? dd : "0" + dd[0]) + " " + (hh[1] ? hh : "0" + hh[0]) + ":" + (mi[1] ? mi : "0" + mi[0]) + ":" + (ss[1] ? ss : "0" + ss[0]) ;
};

Date.prototype.getLastDate = function(){
    return new Date(this.getFullYear(),this.getMonth()+1,0).getDate();
};


String.prototype.htmlChars = function() { 
    var str = ((this.replace('"', '&amp;')).replace('"', '&quot;')).replace('\'', '&#39;'); 
    return (str.replace('<', '&lt;')).replace('>', '&gt;');
} 

/**
 * ******************************************************************************************************
 */

/**
 * HashMap()
 */
var HashMap = function() {
	var mapVal = {}; // private
	var pos = new Array();

	this.get = function(key) {
		return mapVal[key];
	};

	this.getPos = function(n) {
		return mapVal[pos[n]];
	};

	this.getKey = function(n) {
		return pos[n];
	};

	this.getAllKey = function() {
		return pos;
	};

	this.remove = function(n) {
		var ary = new Array();
		for (var i = 0; i < pos.length; i++) {
			if (pos[i] != n) {
				ary.push(pos[i]);
			}
		}
		pos = ary;
	};

	this.put = function(key, val) {
		mapVal[key] = val;
		var flg = true;
		for (var i = 0; i < pos.length; i++) {
			if (key == pos[i])
				flg = false;
		}
		if (flg)
			pos.push(key);
	};

	this.size = function() {
		return pos.length;
	};
};

Map = function(){
	 this.map = new Object();
	};   
	Map.prototype = {   
	    put : function(key, value){   
	        this.map[key] = value;
	    },   
	    get : function(key){   
	        return this.map[key];
	    },
	    containsKey : function(key){    
	     return key in this.map;
	    },
	    containsValue : function(value){    
	     for(var prop in this.map){
	      if(this.map[prop] == value) return true;
	     }
	     return false;
	    },
	    isEmpty : function(key){    
	     return (this.size() == 0);
	    },
	    clear : function(){   
	     for(var prop in this.map){
	      delete this.map[prop];
	     }
	    },
	    remove : function(key){    
	     delete this.map[key];
	    },
	    keys : function(){   
	        var keys = new Array();   
	        for(var prop in this.map){   
	            keys.push(prop);
	        }   
	        return keys;
	    },
	    values : function(){   
	     var values = new Array();   
	        for(var prop in this.map){   
	         values.push(this.map[prop]);
	        }   
	        return values;
	    },
	    size : function(){
	      var count = 0;
	      for (var prop in this.map) {
	        count++;
	      }
	      return count;
	    }
	};
/**
 * ******************************************************************************************************
 */

/**
 * 
 */
$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};
/**
 * 해당 요소(Element)의 자식 Elements(nodeType이 1)만 배열로 리턴
 * @param parent
 * @returns {Array}
 */
function fun_getChildElements(parent) {
	var childs = new Array(), cnt = 0;

	if (parent.childNodes != null) {
		for (var i = 0; i < parent.childNodes.length; i += 1) {
			if (parent.childNodes[i].nodeType == 1) {
				childs[cnt] = parent.childNodes[i];
				cnt += 1;
			}
		}
	}

	return childs;
}
/**
 * 해당엘리먼트의 자식엘리먼트모두삭제.
 * @param el 엘리먼트
 */
function fun_clearElement(el) {
	while (el.hasChildNodes()) {
		el.removeChild(el.firstChild);
	}
}

/**
 * 해당객체가 undefined이면 defstr로 리턴.
 */
function isUndefined(obj, defstr) {
	var result;
	if (obj == null || typeof obj == "undefined") {
		result = defstr;
	} else {
		result = obj;
	}

	return result;
}

function isEmpty(obj, defstr) {
	var result;
	if (obj == null || typeof obj == "undefined" || obj == '') {
		result = defstr;
	} else {
		result = obj;
	}

	return result;
}

/* function : 숫자처리
 * param : String strVal
 */
function isNumber(strVal) {
	var v_str = new String(strVal);
	var j = 0;
	if (strVal == '')
		return true;

	for (var i = 0; i < v_str.length; i++) {
		if ((v_str.substring(i, i + 1) >= '0') && (v_str.substring(i, i + 1) <= '9'))
			j++;
	}

	if (j == v_str.length)
		return true;
	else
		return false;
}

function fun_roundXL(n, digits) {
	if (digits >= 0) return parseFloat(n.toFixed(digits)); // 소수부 반올림

	digits = Math.pow(10, digits); // 정수부 반올림
	var t = Math.round(n * digits) / digits;
	return parseFloat(t.toFixed(0));
}

/**
 * hhmmss -> hh?mm?ss 형식으로 변환.
 * @param strTime
 * @param strFormat
 * @returns {String}
 */
function fun_getHHMMSS(strTime, strFormat) {
	var result = '';
	if (strTime != null && strTime != '') {
		result += strTime.substring(0, 2);
		result += isUndefined(strFormat, '');
		result += strTime.substring(2, 4);
		result += isUndefined(strFormat, '');
		result += strTime.substring(4, 6);
	}

	return result;
}
/**
 * yyyymmdd -> yyyy?mm?dd 형식으로 변환.
 * @param strTime
 * @param strFormat
 * @returns {String}
 */
function fun_getYYYYMMDD(strTime, strFormat) {
	var result = '';
	if (strTime != null && strTime != '') {
		result += strTime.substring(0, 4);
		result += isUndefined(strFormat, '');
		result += strTime.substring(4, 6);
		result += isUndefined(strFormat, '');
		result += strTime.substring(6, 8);
	}

	return result;
}
/**
 * yyyymm -> yyyy?mm 형식으로 변환.
 * @param strTime
 * @param strFormat
 * @returns {String}
 */
function fun_getYYYYMM(strTime, strFormat) {
	var result = '';
	if (strTime != null && strTime != '') {
		result += strTime.substring(0, 4);
		result += isUndefined(strFormat, '');
		result += strTime.substring(4, 6);
	}

	return result;
}

/**
 * 날짜 포맷 변경(시간)
 * @param {} strDate
 * @param {} strFormat
 * @return {}
 */
function fun_getFormatTime(strDate, strFormat) {
	var result = '';
	var delimeter = isUndefined(strFormat, '');

	if (typeof strDate != "string") {
		var date = new Date(strDate), hours = date.getHours(), minutes = date.getMinutes(), second = date.getSeconds();

		result = fun_chNumerToStr(hours) + delimeter
				+ fun_chNumerToStr(minutes) + delimeter
				+ fun_chNumerToStr(second);

	} else {
		if (strDate == null || strDate == undefined || !strDate.length == 6) {
			return strDate;
		}

		strDate = strDate.replace('\:', '');

		// 날짜를 가져온다.
		result += strDate.substring(0, 2);

		if (strDate.length > 4) {
			result += delimeter;
			result += strDate.substring(2, 4);

			if (strDate.length > 6) {
				result += delimeter;
				result += strDate.substring(2, 4);
			}
		}
	}
	return result;
}

/**
 * 날짜 포맷 변경
 * @param {} strDate
 * @param {} strFormat
 * @return {}
 */
function fun_getFormatDate(strDate, strFormat) {
	var result = '';
	var delimeter = isUndefined(strFormat, '');

	if (typeof strDate != "string") {
		var date = new Date(strDate), year = date.getFullYear(), month = date.getMonth() + 1, day = date.getDate();

		result = fun_chNumerToStr(year) + delimeter + fun_chNumerToStr(month) + delimeter + fun_chNumerToStr(day);

	} else {
		if (strDate == null || !(strDate.length == 6 || strDate.length == 8 || strDate.length == 14)) {
			return strDate;
		}

		// 날짜를 가져온다.
		result += strDate.substring(0, 4);

		if (strDate.length > 4) {
			result += delimeter;
			result += strDate.substring(4, 6);

			if (strDate.length > 6) {
				result += delimeter;
				result += strDate.substring(6, 8);
			}
		}
	}
	return result;
}

/**
 * 숫자형 2자리 문자형으로 변경
 * @param {} val
 * @return {}
 */
function fun_chNumerToStr(val) {
	val = (val == null) ? 0 : Number(val);

	var result = val;
	if (val < 10 && val > -1) {
		result = '0' + val;
	} else {
		result = '' + val;
	}

	return result;
}

/**
 * 텍스트 입력시 bytes 자동 설정.
 * @param text
 * @param target
 */
function fun_length(text, target) {
	var msgtext = document.getElementById(text);
	document.getElementById(target).value = fun_getLength(msgtext.value);
}

/**
 * 문자를 바이트 크기로 가져오기
 * @param {} str
 * @return {}
 */

function fun_getLength(str) {
	var length = 0;
	str = replaceAll(str, '\r', ' ');

	if (str != null && str != '') {
		length = (str.length + (escape(str) + '%u').match(/%u/g).length - 1);
	}
	return length;
}

function fun_loadScript(url, callback) {
	var script = document.createElement("script");
	script.type = "text/javascript";

	if (script.readyState) { // 인터넷 익스플로어
		script.onreadystatechange = function() {
			if (script.readyState == "loaded" || script.readySate == "complete") {
				script.onreadystatechange = null;
				callback();
			}
		}
	} else {
		script.onload = function() {
			callback();
		}
	}
	script.src = url;
	document.getElementsByTagName("head")[0].appendChild(script);
}

/*
 * 셀렉트 박스의 모든 option을 삭제해준다.
 */
function selectbox_deletelist(targetid) {
	var targetObj = document.getElementById(targetid);
	for (i = targetObj.length; i > 0; i--) {
		targetObj.remove(i);
	}
}

function selectbox_deletealllist(targetid) {
	var targetObj = document.getElementById(targetid);
	for (i = targetObj.length; i >= 0; i--) {
		targetObj.remove(i);
	}
}

function selectbox_insert(obj, s_text, s_val, isSel) {
	obj.options[obj.length] = new Option(s_text, s_val, false, isSel);
}

function selectbox_insert_sel(obj, s_text, s_val, isSel) {
	obj.options[obj.length] = new Option(s_text, s_val, false, isSel);
}

/**
 * 셀렉트 박스 리스트를 생성해준다. 
 */
function selectbox_insertlist(targetid, list, selected, firstCode, firstName, delallyn) {
	var targetObj = document.getElementById(targetid);
	var info;
	// target의 모든 데이터를 삭제해준다.
	if(delallyn == undefined)
		selectbox_deletelist(targetid);
	else 
		selectbox_deletealllist(targetid);

	if (firstCode != undefined && firstName != undefined && firstName != '')
		selectbox_insert(targetObj, firstName, firstCode, false);

	// 가져온 데이터를 넣어준다.
	if (list != null && list.length > 0) {
		lstIndex = list.length;
		for (var i = 0; i < list.length; i++) {
			info = list[i];
			if (selected != undefined && selected != '' && info["code"] == selected)
				selectbox_insert(targetObj, info["codenm"], info["code"], true);
			else
				selectbox_insert(targetObj, info["codenm"], info["code"], false);
		}
	}
}

/**
 * 셀렉트 박스 리스트를 생성해준다. 
 */
function selectbox_direct_insertlist(targetid, list, selected, firstCode,
		firstName) {
	var targetObj = document.getElementById(targetid);
	var info;

	if (firstCode != undefined && firstName != undefined && firstName != '')
		selectbox_insert(targetObj, firstName, firstCode, false);

	// 가져온 데이터를 넣어준다.
	if (list != null && list.length > 0) {
		lstIndex = list.length;
		for (var i = 0; i < list.length; i++) {
			info = list[i];
			if (selected != undefined && selected != '' && info["code"] == selected)
				selectbox_insert(targetObj, info["codenm"], info["code"], true);
			else
				selectbox_insert(targetObj, info["codenm"], info["code"], false);
		}
	}
}

function selectbox_insertlist_sel(targetid, list, key) {

	var targetObj = document.getElementById(targetid);
	var info;
	// target의 모든 데이터를 삭제해준다.
	selectbox_deletelist(targetid);

	// 가져온 데이터를 넣어준다.
	if (list != null && list.length > 0) {
		lstIndex = list.length;
		for (var i = 0; i < list.length; i++) {
			info = list[i];
			if (info["code"] == key)
				selectbox_insert_sel(targetObj, info["codenm"], info["code"],
						true);
			else
				selectbox_insert_sel(targetObj, info["codenm"], info["code"],
						false);
		}

	}

}

getCommonCodeList = function(gubuncode, objid, selected, firstCode, firstName, asyncyn) {

	$.ajax({
		type : "POST",
		url : "/code/commonCodeList.do",
		async : asyncyn != undefined && asyncyn != null
				&& asyncyn == "N" ? false : true,
		dataType : 'json',
		data : {
			gubun : gubuncode
		},
		success : function(data, dataType) {
			if (data != null && data.list != null) {
				selectbox_insertlist(objid, data.list, selected,
						firstCode, firstName);
			}

		}
	});
}

getCodeList = function(purl, pdata, objid, selected, firstCode, firstName, asyncyn, delallyn) {

	$.ajax({
		type : "POST",
		url : purl,
		async : asyncyn != undefined && asyncyn != null
				&& asyncyn == "N" ? false : true,
		data : pdata,
		success : function(data, dataType) {
			if (data != null && data.list != null) {
				selectbox_insertlist(objid, data.list, selected, firstCode, firstName, delallyn);
			}
		}
	});
}

getCodeListStr = function(purl, pdata, selected, firstName) {

	var str = "";
	$.ajax({
		type : "POST",
		url : purl,
		async : false,
		data : pdata,
		success : function(data, dataType) {
			if(firstName != "" && firstName != "undefined")
			str += "<option value=''>- "+firstName+" -</option>"
			if (data != null && data.list != null) {
				var item = null;
				for(var i =0; i < data.list.length;i++){
			         item = data.list[i];
					str += "<option value='"+item.code +"' "+(item.code==selected?"selected":"")+">"+item.codenm+"</option>"
				}
			}			
		}
	});
	return str;
}

getJqgridCommonCodeList = function(gubuncode, firstCode, firstName) {
	var map = {};
	$.ajax({
		type : "POST",
		url : "/system/getCommonCodeList.do",
		async : false,
		global : false,
		dataType : 'json',
		data : {
			gubunCode : gubuncode
		},
		success : function(data, dataType) {
			if (data != null && data.list != null) {
				var list = data.list;
				if (list.length > 0 && firstName != null && firstName != "") {
					map[firstCode] = firstName;
				}

				for (var i = 0; i < list.length; i++) {
					map[list[i].code] = list[i].codeNm;
				}

				if (list.length > 0)
					return map;
				else
					null;
			}

		}
	});
}

getJqgridCodeList = function(purl, pdata, firstCode, firstName) {
	var map = {};
	$.ajax({
		type : "POST",
		url : purl,
		async : false,
		global : false,
		data : pdata,
		success : function(data, dataType) {
			if (data != null && data.list != null) {
				var list = data.list;
				if (list.length > 0 && firstName != null && firstName != "") {
					map[firstCode] = firstName;
				}

				for (var i = 0; i < list.length; i++) {
					map[list[i].code] = list[i].codeNm;
				}

				if (list.length > 0)
					return map;
				else
					null;
			}
		}
	});
}

setIdDisp = function(objnm, dispyn) {
	if (dispyn == 'H')
		$("[id=" + objnm + "]").hide();
	else
		$("[id=" + objnm + "]").show();
}

setClassDisp = function(objnm, dispyn) {
	if (dispyn == 'H')
		$("." + objnm).hide();
	else
		$("." + objnm).show();
}

valueValidator = function(object, j, objid, objnm) {
	var cms;
	var columnNames;
	if (objid != null) {
		cms = jQuery("#" + objid).jqGrid("getGridParam", "colModel");
		columnNames = $("#" + objid).jqGrid('getGridParam', 'colNames');
	} else {
		cms = jQuery("#list").jqGrid("getGridParam", "colModel");
		columnNames = $("#list").jqGrid('getGridParam', 'colNames');
	}
	var j = j + 1;
	var val;
	var edtrul;
	for ( var key in object) {
		for (var i = 0; i < cms.length; i++) {
			if (cms[i].name == key && cms[i].editrules != undefined) {
				val = object[key];
				edtrul = cms[i].editrules;
				if (edtrul.required === true) {
					if ($.jgrid.isEmpty(val)) {
						if (objnm != null) {
							$.jgrid.info_dialog($.jgrid.errors.errcap, objnm
									+ j + "번째" + columnNames[i]
									+ "는(은) 필수항목입니다", $.jgrid.edit.bClose, "",
									j, i, objid);
						} else {
							$.jgrid.info_dialog($.jgrid.errors.errcap, j
									+ "번째 " + columnNames[i] + "는(은) 필수항목입니다",
									$.jgrid.edit.bClose, "", j, i, objid);
						}
						return false;
					}
				}
			}
		}
	}
	return true;
}

/**
 * 특정 문자열을 일괄적으로 바꿔준다.
 * @param str
 * @param orgStr
 * @param repStr
 * @returns
 */
function replaceAll(str, orgStr, repStr) {
	return str.split(orgStr).join(repStr);
}

/**
 * 이메일 체크
 * 
 * @param email
 * @return boolean
 */
function isEmail(email) {
	re = /[^@]+@[A-Za-z0-9_-]+[.]+[A-Za-z]+/;

	if (re.test(email)) {
		return true;
	}

	return false;
}

function convertDateType(selector) {

	var date = $("#" + selector).datepicker({
		dateFormat : "yy-mm-dd"
	}).val();
	var o_date = dateToObject(date);

	if (!isValidDate(o_date.toString1("-"))) {
		alert('유효한 날짜가 아닙니다');
		$("#" + selector).focus();
		return false;
	}

	$("#" + selector).val(o_date.toString1("-"));
	$("#" + selector + "_month").val(o_date.year);
	$("#" + selector + "_day").val(o_date.month);
	$("#" + selector + "_year").val(o_date.day);
	return true;
}

/**
 * 문자열을 date 타입 객체로 변환 한다 
 * @param p_date
 * @returns {___anonymous64408_65436}
 */
function dateToObject(p_date) {
	var today = new Date();
	var cuyear = today.getFullYear();
	var curmonth = today.getMonth() + 1;
	if (p_date.length == 4) {
		p_date = cuyear + "" + p_date;
	} else if (p_date.length == 2) {
		p_date = cuyear + "" + curmonth + "" + p_date;
	}
	// if p_date is date value of string type
	var part_str_arr = [ "-", "/", ":", "." ];
	var v_date = p_date ? trim(p_date) : "";
	var v_result = {
		"year" : "",
		"month" : "",
		"day" : "",
		"hour" : "",
		"minute" : "",
		"second" : "",
		"toString1" : function(p_date_div) {
			var v_result = "";
			if (trim(this.year) != "")
				v_result += this.year;
			if (trim(this.month) != "")
				v_result += p_date_div + this.month;
			if (trim(this.day) != "")
				v_result += p_date_div + this.day;
			if (trim(this.hour) != "")
				v_result += " " + this.hour;
			if (trim(this.minute) != "")
				v_result += ":" + this.minute;
			if (trim(this.second) != "")
				v_result += ":" + this.second;
			return v_result;
		},
		"toString2" : function() {
			var v_result = "";
			if (trim(this.year) != "")
				v_result += "" + this.year;
			if (trim(this.month) != "")
				v_result += "" + this.month;
			if (trim(this.day) != "")
				v_result += "" + this.day;
			if (trim(this.hour) != "")
				v_result += "" + this.hour;
			if (trim(this.minute) != "")
				v_result += "" + this.minute;
			if (trim(this.second) != "")
				v_result += "" + this.second;
			return v_result;
		}
	};

	if (v_date == "")
		return v_result;

	for (var i = 0; i < part_str_arr.length; i++) {
		v_date = replaceAll(v_date, part_str_arr[i], " ");
	}

	for (var i = 0; i < 10; i++) {
		if (v_date.indexOf("  ") == -1)
			break;
		v_date = replaceAll(v_date, "  ", " ");
	}

	if (v_date) {
		if (v_date.indexOf(" ") != -1) {
			var v_date_arr = v_date.split(" ");
			v_result.year = v_date_arr[0] ? v_date_arr[0] : "";
			v_result.month = v_date_arr[1] ? v_date_arr[1] : "";
			v_result.day = v_date_arr[2] ? v_date_arr[2] : "";
			v_result.hour = v_date_arr[3] ? v_date_arr[3] : "";
			v_result.minute = v_date_arr[4] ? v_date_arr[4] : "";
			v_result.second = v_date_arr[5] ? v_date_arr[5] : "";
		} else {
			v_result.year = v_date.length >= 4 ? v_date.substring(0, 4) : "";
			v_result.month = v_date.length >= 6 ? v_date.substring(4, 6) : "";
			v_result.day = v_date.length >= 8 ? v_date.substring(6, 8) : "";
			v_result.hour = v_date.length >= 10 ? v_date.substring(8, 10) : "";
			v_result.minute = v_date.length >= 12 ? v_date.substring(10, 12)
					: "";
			v_result.second = v_date.length >= 14 ? v_date.substring(12, 14)
					: "";
		}
	}
	return v_result;
}

/**
 * trim
 * 
 * @param text
 * @return string
 */
function trim(text) {
	if (text == "") {
		return text;
	}

	var len = text.length;
	var st = 0;

	while ((st < len) && (text.charAt(st) <= ' ')) {
		st++;
	}

	while ((st < len) && (text.charAt(len - 1) <= ' ')) {
		len--;
	}

	return ((st > 0) || (len < text.length)) ? text.substring(st, len) : text;
}

function isValidDate(param) {
	try {
		if (param == '')
			return true;

		param = param.replace(/-/g, '');
		// 자리수가 맞지않을때
		if (isNaN(param) || param.length != 8) {
			return false;
		}

		var year = Number(param.substring(0, 4));
		var month = Number(param.substring(4, 6));
		var day = Number(param.substring(6, 8));
		var dd = day / 0;

		if (month < 1 || month > 12) {
			return false;
		}

		var maxDaysInMonth = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
		var maxDay = maxDaysInMonth[month - 1];

		// 윤년 체크
		if (month == 2 && (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)) {
			maxDay = 29;
		}

		if (day <= 0 || day > maxDay) {
			return false;
		}
		return true;

	} catch (err) {
		return true;
	}
}

/*
 * @param string grid_id 사이즈를 변경할 그리드의 아이디
 * @param string div_id 그리드의 사이즈의 기준을 제시할 div 의 아이디
 * @param string width 그리드의 초기화 width 사이즈
 */
function resizeJqGridWidth(grid_id, div_id, width) {
	// window에 resize 이벤트를 바인딩 한다.
	$(window).bind('resize', function() {
		// 그리드의 width 초기화
		$('#' + grid_id).setGridWidth(width, false);
		// 그리드의 width를 div 에 맞춰서 적용
		$('#' + grid_id).setGridWidth($('#' + div_id).width(), false); //Resized to new width as per window
		$(".ui-jqgrid-htable").css("width", $('#' + div_id).width());
		$(".ui-jqgrid-btable").css("width", $('#' + div_id).width());
	}).trigger('resize');
}

Map = function() {
	this.map = new Object();
};
Map.prototype = {
	put : function(key, value) {
		this.map[key] = value;
	},
	get : function(key) {
		return this.map[key];
	},
	containsKey : function(key) {
		return key in this.map;
	},
	containsValue : function(value) {
		for ( var prop in this.map) {
			if (this.map[prop] == value)
				return true;
		}
		return false;
	},
	isEmpty : function(key) {
		return (this.size() == 0);
	},
	clear : function() {
		for ( var prop in this.map) {
			delete this.map[prop];
		}
	},
	remove : function(key) {
		delete this.map[key];
	},
	keys : function() {
		var keys = new Array();
		for ( var prop in this.map) {
			keys.push(prop);
		}
		return keys;
	},
	values : function() {
		var values = new Array();
		for ( var prop in this.map) {
			values.push(this.map[prop]);
		}
		return values;
	},
	size : function() {
		var count = 0;
		for ( var prop in this.map) {
			count++;
		}
		return count;
	}
};

/* ----------------------------------------------------------------------------
 * 특정 날짜에 대해 지정한 값만큼 가감(+-)한 날짜를 반환

 * 

 * 입력 파라미터 -----
 * pInterval : "yyyy" 는 연도 가감, "m" 은 월 가감, "d" 는 일 가감
 * pAddVal  : 가감 하고자 하는 값 (정수형)
 * pYyyymmdd : 가감의 기준이 되는 날짜
 * pDelimiter : pYyyymmdd 값에 사용된 구분자를 설정 (없으면 "" 입력)

 * 

 * 반환값 ----

 * yyyymmdd 또는 함수 입력시 지정된 구분자를 가지는 yyyy?mm?dd 값
 *

 * 사용예 ---

 * 2008-01-01 에 3 일 더하기 ==> addDate("d", 3, "2008-08-01", "-");

 * 20080301 에 8 개월 더하기 ==> addDate("m", 8, "20080301", "");
 --------------------------------------------------------------------------- */
function addDate(pInterval, pAddVal, pYyyymmdd, pDelimiter) {
	var yyyy;
	var mm;
	var dd;
	var cDate;
	var oDate;
	var cYear, cMonth, cDay;

	if (pDelimiter != "") {
		pYyyymmdd = pYyyymmdd.replace(eval("/\\" + pDelimiter + "/g"), "");
	}

	yyyy = pYyyymmdd.substr(0, 4);
	mm = pYyyymmdd.substr(4, 2);
	dd = pYyyymmdd.substr(6, 2);

	if (pInterval == "yyyy") {
		yyyy = (yyyy * 1) + (pAddVal * 1);
	} else if (pInterval == "m") {
		mm = (mm * 1) + (pAddVal * 1);
	} else if (pInterval == "d") {
		dd = (dd * 1) + (pAddVal * 1);
	}

	cDate = new Date(yyyy, mm - 1, dd) // 12월, 31일을 초과하는 입력값에 대해 자동으로 계산된 날짜가 만들어짐.
	cYear = cDate.getFullYear();
	cMonth = cDate.getMonth() + 1;
	cDay = cDate.getDate();

	cMonth = cMonth < 10 ? "0" + cMonth : cMonth;
	cDay = cDay < 10 ? "0" + cDay : cDay;

	if (pDelimiter != "") {
		return cYear + pDelimiter + cMonth + pDelimiter + cDay;
	} else {
		return cYear + cMonth + cDay;
	}

}

/**
 * 현재날짜를 리턴한다.
 * 
 */
function getCurDate() {
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
	var day = date.getDate();
	var hour = date.getHours();
	var min = date.getMinutes();

	if (("" + month).length == 1) {
		month = "0" + month;
	}
	if (("" + day).length == 1) {
		day = "0" + day;
	}
	if (("" + hour).length == 1) {
		hour = "0" + hour;
	}
	if (("" + min).length == 1) {
		min = "0" + min;
	}

	return ("" + year + month + day);
}

	function getAge(yyyymmdd) {
	//REQUIRED: yyyymmdd 태어난 생년월일이에요. 예) 19800205
	var age; //리턴할 만 나이

	var yyyy = parseInt(String(yyyymmdd).substring(0,4),10);
	var mmdd = String(yyyymmdd).substring(4,6) + String(yyyymmdd).substring(6,8);

	var d = new Date();
	var tmonth = d.getMonth() + 1; //getMonth는 0(1월)~11(12월)을 반환합니다.
	var tdate = d.getDate();

	//자리수를 맞춰주기 위한 처리. 한 자리일 떄 앞에 0을 붙여줍니다.
	var today = ((tmonth < 10)? '0' + tmonth : tmonth) + ((tdate < 10)? '0' + tdate : tdate);
	age = d.getFullYear() - yyyy + 1;
	
	//생일이 지났는지 체크하여 계산
	if (today < mmdd) {
		age = age - 2;
	} else {
		age = age - 1;
	}

	return age;
};

function jsNvl(str) {
	var result = "";
	if (str == undefined || str == null || str == "null" || str == "NULL") {
		result = "";
	} else {
		result = str;
	}

	return result;
}

function jsNvlTrim(str) {
	var result = "";
	if (str == undefined || str == null || str == "null" || str == "NULL") {
		result = "";
	} else {
		result = trim(str);
	}

	return result;
}


function jsNumnvl(str) {
	if (str == null || str == "") {
		return "0";
	}
	return str;
}
/**
 * 숫자에 comma를 붙인다.
 * 
 * @param str
 */
function addCommaStr(str) {
	if (str == "NaN")
		return "0";
	var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
	var arrNumber = str.split('.');
	arrNumber[0] += '.';
	do {
		arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2');
	} while (rxSplit.test(arrNumber[0]));

	if (arrNumber.length > 1) {
		replaceStr = arrNumber.join("");
	} else {
		replaceStr = arrNumber[0].split(".")[0];
	}
	return replaceStr;
}

function intcuttig(str1, unit) {
	var retuval = "";
	var temp = "";

	temp = str1 == "" ? "0" : str1;

	retuval = parseInt(parseInt(temp) / unit) * unit;

	return retuval;
}

function median(values) {
	values.sort(function(a, b) {
		return a - b;
	});
	var half = Math.floor(values.length / 2);
	if (values.length % 2) {
		return values[half];
	} else {
		return (values[half - 1] + values[half]) / 2.0;
	}
}

/**
 * 콤마찍기
 * @param str
 * @returns
 */
function commaNum(str) {
	str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function addCommas(input) {
	if (input == undefined)
		return "";
	else
		// If the regex doesn't match, `replace` returns the string unmodified
		return (input.toString()).replace(
		// Each parentheses group (or 'capture') in this regex becomes an argument 
		// to the function; in this case, every argument after 'match'
		/^([-+]?)(0?)(\d+)(.?)(\d+)$/g, function(match, sign, zeros, before,
				decimal, after) {

			// If a digit has 3 digits after it, replace it with itself plus a comma
			var insertCommas = function(string) {
				return string.replace(/(\d)(?=(\d{3})+$)/g, "$1,");
			};

			// If there was no decimal, the last capture grabs the final digit, so
			// we have to put it back together with the 'before' substring
			return sign
					+ (decimal ? insertCommas(before) + decimal + after
							: insertCommas(before + after));
		});
}

// sortByKey 함수는 자바스크립트에서 제공하는 sort를 이용하여 구현
function sortByKey(array, key, order, isnumber) {
	return array.sort(function(a, b) {
		var x = isnumber ? parseFloat(a[key]) : a[key];
		var y = isnumber ? parseFloat(b[key]) : b[key];
		if (order == "desc")
			return ((x > y) ? -1 : ((x < y) ? 1 : 0));
		else
			return ((x < y) ? -1 : ((x > y) ? 1 : 0));
	});
}

/*
 * gridid : jqgrid 표시 객체 id, colcnt : jqgrid에 보여지는 컬럼갯수(hidden제외) 
 */
function showJqgridDataNon(data, jqgridid, colcnt) {
	if (data.rows.length == 0) {
		$("#" + jqgridid + " >tbody").append(
				"<tr><td align='center' colspan='" + colcnt
						+ "'>검색 결과가 없습니다.</td></tr>");
	}
}

/**
 * 도움말 팝업
 */
function linkHelpManage(programCode) {

	if($('#content_rti').length > 0) 
		$('#content_rti').append('<div class="modal fade" id="modal-preview"></div>');
	else
		$('#content').append('<div class="modal fade" id="modal-preview"></div>');
	
	$.ajax({
		type : "POST",
		url : "/getPopupHelpManage.do",
		data : {
			programCode : programCode
		},
		dataType : 'json',
		success : function(data) {

			var helpPageList = data.helpPageList;
			if (helpPageList.length > 0) {
				var row_id = helpPageList[0].fileId;
				$.ajax({
					type : "POST",
					url : "/getPreviewContents.do",
					data : {
						row_id : row_id
					},
					dataType : 'html',
					success : function(data) {
						$('#modal-preview').html(data);
						$('#modal-preview').css("z-index", 9999);
						$('.modal-title')[0].innerHTML = '도움말';
						$('#modal-preview').modal();
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("미리보기를 가져오는데 실패하였습니다.");
					}
				});
			} else {
				alert("등록된 도움말파일이 없습니다.");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("도움말 미리보기를 가져오는데 실패하였습니다.");
		}
	});
}

/**
 * 도움말 툴팁
 */
function helpTooltip(toolTipId, programCode, tooltipCode) {
	var selector = $('#' + toolTipId);
	$.ajax({
		url : "/getHelpControlInfo.do",
		type : "POST",
		dataType : 'json',
		data : {
			menuProgramCd : programCode,
			componentCd : tooltipCode
		},
		success : function(data) {
			if (data != null) {
				var helpControlInfo = data.helpControlInfo;
				if (helpControlInfo != null) {
					var returnVal = helpControlInfo.tooltipText;
					selector.attr({
						"title" : returnVal
					});
				}
			} else {
				return " ";
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("툴팁 정보를 가져오는데 실패 하였습니다.");
		}
	});
}


/**
 * <pre>
 * 날짜 비교 함수
 * </pre>
 * 
 * <code>
 * type: d, sDateStr: 2015-01-01, eDateStr: 2015-01-30 ==> 결과 : 29<br />
 * type: d, sDateStr: 2015-02-01, eDateStr: 2015-01-30 ==> 결과 : -2<br />
 * 
 * type: m, sDateStr: 2015-01-01, eDateStr: 2015-04-01 ==> 결과 : 3<br />
 * type: m, sDateStr: 2015-01-21, eDateStr: 2015-05-01 ==> 결과 : 4<br />
 * 
 * type: y, sDateStr: 2015-01-01, eDateStr: 2015-01-30 ==> 결과 : 0<br />
 * type: y, sDateStr: 2015-02-01, eDateStr: 2017-01-30 ==> 결과 : -2<br />
 * </code>
 * <br />
 * 
 * @author P081305
 * @param type: 계산 타입, D - 일, M - 월, Y - 년
 * @param sDate: 시작 일자
 * @param eDate: 종료 일자
 * @return Number: 계산 결과, 음수 - 시작 > 종료, 0 - 같음, 양수 - 시작 < 종료
 * 
 * */
var getDifferenceDate = function( type, sDateStr, eDateStr ) {
	var sDate = new Date( sDateStr );
	var eDate = new Date( eDateStr );
	
	if ( isEmpty(type, "") !== "" ) {
		if ( type.toUpperCase() === "Y" ) { // 년 비교
			return parseInt( (( eDate.getFullYear() - sDate.getFullYear() ) * 12 + ( eDate.getMonth() - sDate.getMonth() )) / 12 );
		} else if ( type.toUpperCase() === "M" ) { // 월 비교
			return ( eDate.getFullYear() - sDate.getFullYear() ) * 12 + ( eDate.getMonth() - sDate.getMonth() );
		} else { // 일 비교
			return ( eDate.getTime() - sDate.getTime() ) / 1000 / 60 / 60 / 24;
		}
	}
};

/**
 * <pre>
 * JqGrid 내에 Select Box 생성
 * Load Complete 시 서버에 공통 코드를 요청 한 후에 설정
 * </pre>
 * 
 * @author P081305
 * @param gridID: JQGrid ID
 * @param colName: Select Box를 넣을 컬럼명
 * @param codeGroup: 설정할 코드 그룹
 * @param URL: 공통코드 외에 코드를 가져올 때 사용하는 URL
 * */
var getCodeListToJqGrid = function( gridID, colName, codeGroup, URL, startText ) {
	var thisUrl = URL || "/system/getCommonCodeList.do";
	
	$.ajax({
		url: thisUrl
		, type: "POST"
		, async: false
		, global: false
		, dataType: "json"
		, data: {
			gubunCode: codeGroup
		}
		, success: function( data ) {
			var codeList = data.list;
			setCodeListToJqGrid( gridID, colName, codeList, null, null, startText );
		}
	});
}


var getListToJqGrid = function( gridID, colName, postdata, URL, startText ) {
	//debugger;
	var thisUrl = URL;
	$.ajax({
		url: thisUrl
		, type: "POST"
		, async: false
		, global: false
		, dataType: "json"
		, data: {
			data : postdata
		}
		, success: function( data ) {
			//debugger;
			var codeList = data.list;
			setCodeListToJqGrid( gridID, colName, codeList, null, null, startText );
		}
	});
}

// 특정 로우....그리드 박스...

var getListToJqGridRow = function( gridID, colName, postdata, URL, startText ) {
	//debugger;
	var thisUrl = URL;
	$.ajax({
		url: thisUrl
		, type: "POST"
		, async: false
		, global: false
		, dataType: "json"
		, data: {
			data : postdata
		}
		, success: function( data ) {
			//debugger;
			var codeList = data;
			setCodeListToJqGridRow( gridID, colName, codeList, null, null, startText );
			
		}
	});
}


var setCodeListToJqGridRow = function( gridID, colName, codeList, key, value, startText ) {
	//debugger;
	var thisCode = key || "code";
	var thisCodeNm = value || "codeNm";
	var thisStartText = startText || "";

	var codeListLen = codeList.length;
	var codeStr = ":" + thisStartText + ";";
	
	for( var idx = 0; idx < codeListLen; idx++ ) {
		var code = codeList[ idx ];
		codeStr += code[thisCode] + ":" + code[thisCodeNm];
		
		if( (idx + 1) !== codeListLen ) {
			codeStr += ";";
		}
	}
	
	convertColList(codeStr);
	
	/*var setCol = $( "#" + gridID ).getColProp( colName );
	setCol.editoptions = {
		value: codeStr
	}
    
	$("#jqgrid-filter-field").jqGrid('setCell', rowid, 'dim_list', "<select><option>aaa</option></select>")
	
	$( "#" + gridID ).setColProp( colName, setCol );*/
}

/**
 * <pre>
 * JqGrid 내에 Select Box 생성
 * Load Complete 시 Data 내에 설정된 List로 설정
 * </pre>
 * 
 * @author P081305
 * @param gridID: JQGrid ID 
 * @param colName: Select Box를 넣을 컬럼명
 * @param codeList: 설정할 코드 리스트
 * @param key: 공통코드 외에 코드를 가져올 때 사용되는 코드 ID값
 * @param vaule: 공통코드 외에 코드를 가져올 때 사용되는 코드 Name 값
 * */
var setCodeListToJqGrid = function( gridID, colName, codeList, key, value, startText ) {
	//debugger;
	var thisCode = key || "code";
	var thisCodeNm = value || "codeNm";
	var thisStartText = startText || "";

	var codeListLen = codeList.length;
	var codeStr = ":" + thisStartText + ";";
	
	for( var idx = 0; idx < codeListLen; idx++ ) {
		var code = codeList[ idx ];
		codeStr += code[thisCode] + ":" + code[thisCodeNm];
		
		if( (idx + 1) !== codeListLen ) {
			codeStr += ";";
		}
	}
	
	var setCol = $( "#" + gridID ).getColProp( colName );
	
	if( isEmpty( setCol.editoptions, "" ) != "" ) {
		setCol.editoptions["value"] = codeStr;
	} else {
		setCol.editoptions = {
			value: codeStr
		}		
	}

	$( "#" + gridID ).setColProp( colName, setCol );
}

/**
 * <pre>
 * Popup 호출 시 사용하는 함수
 * </pre>
 * 
 * @author P081305
 * @param URL: 팝업 주소
 * @param targetDivID: 대상 DIV
 * @param dataObj: parameter 데이터
 * */
var showTargetPopup = function( URL, targetDivID, dataObj ) {
	var targetDiv = $("<div>");
	$( targetDiv ).attr( "id", targetDivID );

	$("body").append( targetDiv );

	$.ajax({
		url: URL
		, type: "POST"
		, target: "#" + targetDivID
		, dataType: "html"
		, data: dataObj
		, success: function( data ) {
			$("#" + targetDivID).html( data );

			$("#" + targetDivID + " > .modal.fade").on(
				"hidden.bs.modal"
				, function( evt ) {
					var thisDivID = evt.target.id;
					var thisParentDivID = thisDivID + "Div";
					
					if( targetDivID === thisParentDivID ) {
						$("#" + targetDivID).remove();	
					}
				}
			);
		}
	});
};

/**
 * <pre>
 * JqGrid Width 값 리사이즈
 * </pre>
 * 
 * @author P081305
 * @param targetGridID: 리사이즈 할 대상 JqGrid ID
 * @param targetGridParentID: 리사이즈 할 대상 JqGrid를 감싸고 있는 Div 태그의 ID
 * */
var setResizeJqGridWidth = function( targetGridID, targetGridParentID ) {
	$(window).resize(function( evt ) {
		var parentDivWidth = $("#" + targetGridParentID).parent().width();
		$("#" + targetGridID).setGridWidth( parentDivWidth - 2 );
	}).trigger( "resize" );
};

/**
 * <pre>
 * JqGrid Cell Save
 * </pre>
 * 
 * @author P081305
 * @param targetGridID: Cell 값을 저장할 JqGrid ID
 * */
var setSaveJqGridCell = function( targetGridID ) {
	var targetGrid = $("#" + targetGridID);
	var targetGridParameter = targetGrid.getGridParam();
	var targetRow = targetGridParameter.iRow || "";
	var targetCol = targetGridParameter.iCol || "";

	if( targetRow !== "" && targetCol !== "" ) {
		targetGrid.saveCell( targetRow, targetCol );
	}};

/**
 * <pre>
 * String Replace All Function
 * </pre>
 * 
 * @author P081305
 * @param sourceStr: 변환할 대상 문자열
 * @param targetStr: 변환할 문자열
 * */
String.prototype.replaceAll = function( sourceStr, targetStr ){
    var temp_str = "";
    var temp_trim = this.replace(/(^\s*)|(\s*$)/g, "");

    if ( temp_trim && sourceStr != targetStr ) {
        temp_str = temp_trim;
        while ( temp_str.indexOf( sourceStr ) > -1 ) temp_str = temp_str.replace( sourceStr, targetStr );
    }

    return temp_str;
};

/**
 * <pre>
 * 문자열 길이 체크 함수
 * </pre>
 * 
 * @author P081305
 * @param sourceID: 문자 길이를 체크할 Text Area ID
 * @param sourceStr: 현재 문자열
 * @param maxByte: 최대 Byte
 * @param resultLengthID: 입력한 문자열의 길이를 보여줄 Input Box ID
 * */
var getByteLength = function ( sourceID, sourceStr, maxByte, resultLengthID ) {
	var byteLen = 0;
	var ch;
	var resultStr = "";
	
	if ( sourceStr === "" ) {
		if ( isEmpty( resultLengthID, "" ) != "" ) {
			$("#" + resultLengthID).val( 0 );
		}
	}

	for ( var i = 0; i < sourceStr.length; i++ ) {
		ch = sourceStr.charCodeAt(i);
		len = ch >> 11 ? 3 : ch >> 7 ? 2 : 1;

		if ( ( len + byteLen ) > maxByte ) {
			$( "#" + sourceID ).val( resultStr );
			return false;
		} else {
			byteLen += len;
		}

		if ( isEmpty( resultLengthID, "" ) != "" ) {
			$("#" + resultLengthID).val( byteLen );
		}

		resultStr += sourceStr[i];
	}
};

/**
 * <pre>
 * 문자열 길이 체크 함수
 * </pre>
 * 
 * @author P081305
 * @param sourceStr: 길이 체크할 문자열
 * @param maxLength: 최대 길이
 * @return rstFlag: 길이 체크 결과, 최대 길이보다 짧다면 true, 길면 false
 * */
var checkByteLength = function ( sourceStr, maxLength ) {
	var byteLen = 0;
	var ch;
	var rstFlag = true;
	
	if( maxLength < 0 ) {
		return rstFlag;
	}

	for ( var i = 0; i < sourceStr.length; i++ ) {
		ch = sourceStr.charCodeAt(i);
		len = ch >> 11 ? 3 : ch >> 7 ? 2 : 1;

		byteLen += len;
		if ( byteLen > maxLength ) {
			rstFlag = false;
		}
	}
	
	return rstFlag;
};

/**
 * <pre>
 * 배열 요소 trim 함수
 * 배열 내에 있는 모든 요소들에 대해 공백제거를 하거나,
 * 해당 요소가 공백이라면 삭제 처리를 한다.
 * </pre>
 * 
 * @author P081305
 * */
setArrayDataTrim = function( targetArray ) {
	var length = targetArray.length;
	for( var idx = length - 1; idx > -1; idx-- ) {
		targetArray[ idx ] = targetArray[ idx ].replace( /(^\s*)|(\s*$)/g, "" );
		
		if( targetArray[ idx ] == "" ) {
			targetArray.splice( idx, 1 );
		}
	}
};

/**
 * <pre>
 * 숫자만 입력 가능하게 처리
 * </pre>
 * 
 * @author P081305
 * @param evt : Key Up 이벤트
 * */
var setNumberOnly = function( evt ) {
	var thisValue = this.value;
	var rexStr = /[^0-9]/gi;
	
	if( rexStr.test( thisValue ) ) {
		$( this ).val( thisValue.replace( rexStr, "" ) );
	}
};

/**
 * <pre>
 * 영문만 입력 가능하게 처리
 * </pre> 
 * 
 * @author P081305
 * @param evt : Key Up 이벤트
 * */
var setEnglishOnly = function( evt ) {
	var thisValue = this.value;
	var rexStr = /[^a-z\s]/gi;
	
	if( rexStr.test( thisValue ) ) {
		$( this ).val( thisValue.replace( rexStr, "" ) );
	}
};

/**
 * jqgrid 메모리 데이터 정렬을 해준다.
 * @param index
 * @param iCol
 * @param sortOrder
 * @param gridId
 */
function jqgridSortCol(index, iCol, sortOrder, gridId){
	//debugger;
	$("#"+gridId).setGridParam({ page:  $("#miv_pageNo").val()}); 
    var colModels = $("#"+gridId).getGridParam("colModel");
    var isnumber = false;
    if(colModels[iCol].formatter == "currency" || colModels[iCol].sorttype == "integer" ) isnumber = true;  
    
    var pageNo = $("#miv_pageNo").val();
    var pageSize = $("#miv_pageSize").val();
     var startNo = ((pageNo*pageSize)-pageSize)+1; 
     // 그리드의 데이터를 가져와서 json sort 해줍니다.
     var obj = jQuery("#"+gridId).jqGrid('getRowData');
     var slen = obj.length;
 	    for(var i = slen ; i>=0 ; i--){								// 선택한 행 수만큼 돌린다	
 		   jQuery("#"+gridId).jqGrid('delRowData',i);
 	    }

   obj = sortByKey(obj, index, sortOrder,isnumber);           
 	   for(var i = 0 ; i<slen ; i++){
 		  obj[i].rnum = startNo++;
 	  	  jQuery("#"+gridId).addRowData(i+1, obj[i]);
 	   }
}

//  jqgird 색상 
var editcolor = "#d4eaeb";
var editcolorstyle = 'style="background-color:'+editcolor+';"';


//모달 열기
function openModal(id){
	$("#"+id).modal();
}


//모달 닫기
function closeModal(id){
	$("#"+id).modal("hide");
}

function checkTextLength(_this, maxLen) {
	var thisVal = $(_this).val();
	var li_byte     = 0, li_len      = 0;
	debugger;
	if(thisVal != undefined){
		var curLen = thisVal.length;
	    for(i=0; i< curLen; i++)
	    {
	      li_byte +=utfCharByteSize(thisVal.charAt(i));

	       // 전체 크기가 li_max를 넘지않으면
	       if(li_byte <= maxLen)
	       {
	          li_len = i + 1;
	       }
	       
			if(li_byte > maxLen){
				var str = $(_this).val().substring(0, li_len);
				$(_this).val(str);
				return false;
			}
	    }

	}
}


function utfCharByteSize(ch) {
    if (ch == null || ch.length == 0) {
        return 0;
      }

      var charCode = ch.charCodeAt(0);

      if (charCode <= 0x00007F) {
        return 1;
      } else if (charCode <= 0x0007FF) {
        return 2;
      } else if (charCode <= 0x00FFFF) {
        return 3;
      } else {
         return 3; 
      }
};

Number.prototype.format = function() {
	if( this == 0 ) return 0;
	
	var reg = /(^[+-]?\d+)(\d{3})/gi;
	var n = ( this + "" );
	
	while ( reg.test( n ) )
		n = n.replace( reg, "$1" + "," + "$2" );
	
	return n;
};

function openPopUp(url, name, width, height)  {
	var xPos = (document.body.clientWidth/2)- (width/2);
	xPos += window.screenLeft;
	var yPos = (screen.availHeight / 2) - (height / 2);
	var args = 'scrollbars=no,toolbar=no,location=no,left='+xPos+',top='+yPos+',width='+width+',height='+height;
	var oWin = window.open(url, name, args);
	return oWin;
}

function openPosPopUp(url, name, width, height, xPos, yPos)  {
	var args = 'scrollbars=no,toolbar=no,location=no,left='+xPos+',top='+yPos+',width='+width+',height='+height;
	var oWin = window.open(url, name, args);
	return oWin;
}

function chkPwd(str){
	 var reg_pwd = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	 if(!reg_pwd.test(str)){
	    return false;
	 }
	 
   return true;
}

function chkNumber(element) {
	var val1 = element.value;
	var num = new Number(val1);
	  
	if(isNaN(num)){
	   
	    alert("숫자만 입력 가능합니다.");
	      element.value = '';
	}
}

//쿠키 가져오기  
function getCookie( name ) {  
   var nameOfCookie = name + "=";  
   var x = 0;  
   while ( x <= document.cookie.length )  
   {  
       var y = (x+nameOfCookie.length);  
       if ( document.cookie.substring( x, y ) == nameOfCookie ) {  
           if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )  
               endOfCookie = document.cookie.length;  
           return unescape( document.cookie.substring( y, endOfCookie ) );  
       }  
       x = document.cookie.indexOf( " ", x ) + 1;  
       if ( x == 0 )  
           break;  
   }  
   return "";  
}  
  
// 24시간 기준 쿠키 설정하기  
// expiredays 후의 클릭한 시간까지 쿠키 설정  
function setCookie( name, value, expiredays ) {   
   var todayDate = new Date();   
   todayDate.setDate( todayDate.getDate() + expiredays );   
   document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
}  


function checkPass(pw){

    	var alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    	var number = "1234567890";
	var sChar = "-_=+\|()*&^%$#@!~`?></;,.:'";

	var sChar_Count = 0;
	var alphaCheck = false;
	var numberCheck = false;
	 
	if(10 <= pw.length || pw.length <= 15){
	    
	    for(var i=0; i<pw.length; i++){
		
		if(sChar.indexOf(pw.charAt(i)) != -1){
		    sChar_Count++;
		}
		
		if(alpha.indexOf(pw.charAt(i)) != -1){
		    alphaCheck = true;
		}
		
		if(number.indexOf(pw.charAt(i)) != -1){
		    numberCheck = true;
		}
		
	    }//for

	    if(sChar_Count < 1 || alphaCheck != true || numberCheck != true){
		alert("비밀번호는 10~15자의 영문,숫자,특수문자의 조합이어야 합니다.");
		return false;
	    }//if
	  
	} else {
	    alert("비밀번호는 10~15자의 영문,숫자,특수문자의 조합이어야 합니다.");
	    return  false;
	}//else
	 
	return true;
}


function onOnlyAlphaNumber(obj) {
	var inText = obj;
	var deny_char = /^[A-Za-z0-9]+$/;

	if (deny_char.test(inText)) {
		return false;
	}
	return true;
}


//-------------------------------------------------- jqGrid관련 공통 시작

/**
*윈도우 리사이즈될때 그리드를 부모영역의 너비로 리사이즈되도록 바인딩. 
*/
function bindWindowJqGridResize(gridId, divId){
    $(window).bind('resize', function() {
//    	debugger;
        // 그리드의 width를 div 에 맞춰서 적용
        doJqGridResize(gridId, divId); 
     }).trigger('resize');
}

/**
*윈도우 리사이즈될때 그리드를 부모영역의 너비로 리사이즈되도록 바인딩. 
*/
function bindWindowJqGridResizeWidth(gridId, divId, width){
    $(window).bind('resize', function() {
    	if($('#' + divId).width() > 100)
           doJqGridResize(gridId, divId);
    	else{
    		width += 56;
    		doJqGridResize(gridId, divId, width);
    	}	
     }).trigger('resize');
}

/**
*윈도우 리사이즈될때 그리드를 창크기 비율로 리사이즈되도록 바인딩. 
*/
function bindWindowJqGridResizeRate(gridId, percentage){
    $(window).bind('resize', function() {
        // 그리드의 width를 div 에 맞춰서 적용
        doJqGridResizeRate(gridId, percentage); 
     }).trigger('resize');
}

/**
*윈도우 리사이즈될때 그리드를 부모영역 비율로 리사이즈되도록 바인딩. 
*/
function bindWindowJqGridResizeDivRate(gridId, divId, percentage){
    $(window).bind('resize', function() {
        // 그리드의 width를 div 에 맞춰서 적용
        doJqGridResizeDivRate(gridId, divId, percentage); 
     }).trigger('resize');
}



/**
*그리드 리사이즈
*/
function doJqGridResize(gridId, divId , width){
//	debugger;
	if(width){
		 $('#' + gridId).setGridWidth(width, true); 
	}else{			
		 $('#' + gridId).setGridWidth($('#' + divId).width()-2 , true); 
	}
        
}

/**
*그리드 리사이즈(창 크기 비율)
*/
function doJqGridResizeRate(gridId, percentage){
	var winWidth = $(window).width();
	var width = Math.round((winWidth / 100) * percentage);
	$('#' + gridId).setGridWidth(width, true);    
}

/**
*그리드 리사이즈(부모영역 비율)
*/
function doJqGridResizeDivRate(gridId, divId, percentage){
	var winWidth = $('#' + divId).innerWidth();
	var width = Math.round((winWidth / 100) * percentage);
	$('#' + gridId).setGridWidth(width, true);    
}


/**
*GET 그리드 데이터 JSON String(초기적재데이터 변경사항 적용안됨)
*/
function getJqGridInitDataJsonString(gridId){	
	return JSON.stringify($('#' + gridId).jqGrid('getGridParam', 'data'));       
}


/**
*GET 그리드 데이터 JSON String 
*/
function getJqGridDataJsonString(gridId){	
	return  JSON.stringify($('#' + gridId).jqGrid('getRowData'));       
}

/**
*그리드 Cell에디터 정리.
*/
function jqGridBeforeEditCell(gridId, rowIdx, colIdx) {
	jQuery("#" + gridId).jqGrid('setGridParam',{
  		selRowIdx : rowIdx,
  		selColIdx : colIdx
	});
}

/**
*그리드 Cell에디터 정리.
*/
function clearJqGridCellEditor(gridId){	
	var rowIdx = $('#' + gridId).jqGrid('getGridParam', 'selRowIdx');
	var colIdx = $('#' + gridId).jqGrid('getGridParam', 'selColIdx');
	var row = jQuery('#'+gridId+' tr:eq('+rowIdx+')');
	
	if(row && row.length > 0){
		if(rowIdx || rowIdx==0){
			if(colIdx || colIdx==0){
				$('#' + gridId).saveCell(rowIdx,colIdx);
			}
		}
	}
}

/**
*그리드 GET Cell값.//보류..
*/
function getJqGridCellValue(gridId, rowId, colName) {
	
    var cell = $('#' + gridId).jqGrid('getCell',rowId,colName);    
    var val = cell.val();
    return val;
}

/**
* jqGrid블락
*/
function blockJqGridOnlyGrid(gridId, message) {
	$("#lui_" + gridId).css('width',$('#gbox_' + gridId).css('width'));
	$("#lui_" + gridId).css('height',$('#gbox_' + gridId).css('height'));
	$("#lui_" + gridId).css('top',$('#' + gridId).css('top'));
	$("#lui_" + gridId).css('left',$('#' + gridId).css('left'));
	$("#lui_" + gridId).css('position','absolute');
   	$("#lui_" + gridId).show();
   	if(message){
   		$("#load_" + gridId).text(message).show();
   	}	 
}

/**
* jqGrid 언블락
*/
function unBlockJqGridOnlyGrid(gridId) {
	$("#lui_" + gridId).css('width',$('body').css('width'));
	$("#lui_" + gridId).css('height',$('body').css('height'));
	$("#lui_" + gridId).css('top',0);
	$("#lui_" + gridId).css('left',0);
	$("#lui_" + gridId).css('position','');
   	$("#lui_" + gridId).hide();
	$("#load_" + gridId).hide();   
}

/**
* 그리드내 모든 체크박스 체크
*/
function checkAllGridCheckbox(gridId){
	$('#' + gridId + ' [type=checkbox]:not(:disabled)').prop('checked', true);
}

/**
* 그리드내 모든 체크박스 체크해제
*/
function unCheckAllGridCheckbox(gridId){
	$('#' + gridId + ' [type=checkbox]:not(:disabled)').prop('checked', false);
}

/**
 * 함수설명 : 화면 중앙에 팝업창
 * 예제     : nmPopupCenter(url, object,windowWidth, windowHeight, windowFeatures);
* @ parameter : sTargetPath : 해당 popup창의 실제 페이지 경로
                              object          : popup창으로 넘길 object
                              windowWidth     : 창의 넓이
                              windowHeight    : 창의 높이
                              windowFeatures  : 창의 속성
 */
openWinC = function (url, windowName, sParam, windowWidth, windowHeight, windowFeatures){
	
    try {
        if( windowFeatures == null || windowFeatures == "" ) {
            windowFeatures = "toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no";
        }
        //windowFeatures="";
        //alert(windowFeatures);
        
        
        if(navigator.appVersion.indexOf("Safari") > 0 && navigator.appVersion.indexOf("Chrome") < 0 && navigator.appVersion.indexOf("Version/5.1") > 0) {
            windowHeight = parseInt(windowHeight) - 61;
        }
        
        
        if(navigator.appVersion.indexOf("Chrome") < 0) {
            windowHeight = parseInt(windowHeight) - 61;
        }

        if(navigator.appVersion.indexOf("Chrome") > 0) {
        	windowWidth = parseInt(windowWidth) + 165;
        	windowHeight = parseInt(windowHeight) + 20;
        }

        var xPos = (screen.availWidth  - windowWidth) / 2;
        var yPos = (screen.availHeight - windowHeight) / 2;
        var feature =  "top=" + yPos + ",left=" + xPos + ",width=" + windowWidth + ",height=" + windowHeight +  "," + windowFeatures;
        if(!windowName) {
        	//windowName = "_blank";
        	windowName = "LOFA_POP";
        }
        var newUrl = url;
        if(sParam) {
        	newUrl = newUrl+"?"+sParam;
        }
        var oWin = window.open( newUrl , windowName, feature );
        
 		setTimeout(function(){
 			oWin.focus();
 		}, 1000);
 		
        return oWin;
    } catch(errorObject) {
		alert("Opening a pop-up window was blocked. Please allow opening a pop-ups  for this site");
    }
};

//------------------------------------------------------------------------------------------------------------jqgrid 관련 끝


function goTwitter(t, u) {
	var snsUrl = "https://twitter.com/intent/tweet?text=" + encodeURIComponent(t) + "&url="+encodeURIComponent(u);
    window.open(snsUrl, 'twitter', 'width=450px, height=450px');
}

function goFacebook(u) {
    var url = "http://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(u);
    window.open(url, 'facebook', 'width=450px, height=450px');
}

function contentsPrint(div) {
	var initBody = document.body.innerHTML;
	
	var beforePrint = function() {
		 document.body.innerHTML = document.getElementById(div).innerHTML;
	};
	
	var afterPrint = function() {
		document.body.innerHTML = initBody;
	}
	
	if (window.matchMedia) {
        var mediaQueryList = window.matchMedia('print');
        mediaQueryList.addListener(function(mql) {
            if (mql.matches) {
                beforePrint();
            } else {
                afterPrint();
            }
        });
    }
	
	window.onbeforeprint = beforePrint;
    window.onafterprint = afterPrint;
    
    window.print();
}

// tab
$(function() {
    
    $(".area_tab > ul.tablist li").click(function() {
	
        var now_tab = $(this).index();
        
        $(this).parent().find("li").removeClass("on");        
        $(this).parent().parent().parent().find(".tab").addClass("hidden");
        
        $(this).parent().find("li").eq(now_tab).addClass("on");        
        $(this).parent().parent().parent().find(".tab").eq(now_tab).removeClass("hidden");
        
    });
});

$(document).ajaxStart(function() {
    
    // 로딩 바 이미지를 띄우고 
    $('#hideloading').show();
    
}).ajaxStop(function() {
    
    // 로딩 바 태그와 이미지를 모두 hide 처리
    $('#hideloading').hide();
    
    //console.log("hide"+"|"+this);
    $('#hideloadingmessage').html("");
}
);

$.ajaxSetup({
	beforeSend: function(xhr) {
	    xhr.setRequestHeader("AJAX", true);
	},
	error: function(xhr, status, err) {
	    if (xhr.status == 401) {
		alert("인증에 실패 했습니다. 로그인 페이지로 이동합니다.");
		location.href = "/j_spring_security_logout";
	    } else if (xhr.status == 403) {
		alert("세션이 만료가 되었습니다. 로그인 페이지로 이동합니다.");
		location.href = "/j_spring_security_logout";
	    } else if (xhr.status == 500) {
		alert("서버에 문제가 생겨서 처리하지 못하였습니다. 관리자에게 문의하세요.");
	    }
	}
});


function closePopup(){
	window.close();
}