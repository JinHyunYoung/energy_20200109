// 기업디렉토리 기본정보 조회
function selectCmpyDir(){
	
	if($('#dir_sn').val() == null || $('#dir_sn').val() == ""){
		return;
	}
	
	$("#cmpyDir").html( '' );
		
    $.ajax({
        url: $('#homepage_tp').val() + "searchCmpyDir.do",
        dataType: "html",
        type: "post",
        async: false,
        data: {
           dir_sn : $('#dir_sn').val(),
           lang : $("#lang").val()
		},
        success: function(data) {
        	$( '#cmpyDir' ).html( data );        	
        	setButton('#btn_cmpy_dir');
//        	setButton('#btn_cmpy_dir_manager');
        	setButton('#btn_cmpy_dir_brec');
        	setButton('#btn_cmpy_dir_map');
        	setButton('#btn_cmpy_dir_auth');        	
        },
        error: function(e) {
            alert( '기본정보 데이터를 가져오는데 실패했습니다.' );
        }
    });
}

// 기업디렉토리 기본정보 팝업
function popupCmpyDir(){
	
	$( '#pop_contentCmpyDir' ).html( '' );		
	
    $.ajax({
        url: $('#homepage_tp').val() + "searchCmpyDir.do",
        dataType: "html",
        type: "post",
        data: {
           dir_sn : $('#dir_sn').val(),
           lang : $("#lang").val(),
           popup : "Y"
		},
        success: function(data) {
        	$( '#pop_contentCmpyDir' ).html( data );
        	popupShow();
        },
        error: function(e) {
            alert( '기본정보 데이터를 가져오는데 실패했습니다.' );
        }
    });
}

//기업디렉토리 기본정보 수정
function updateCmpyDir(){	

	if ( $("#cmpyDirUpdateForm").parsley().validate() ){
		
		if ($("#file_id").val() != null && $("#file_id").val() != ""){
			if (!$("#file_id").val().toLowerCase().match(/\.(jpg|png|gif)$/)){
				alert("확장자가 jpg,png,gif 파일만 업로드가 가능합니다.");
				return;
			} 			
		}
		
		if ($("#file_id_en").val() != null && $("#file_id_en").val() != ""){
			if (!$("#file_id_en").val().toLowerCase().match(/\.(jpg|png|gif)$/)){
				alert("확장자가 jpg,png,gif 파일만 업로드가 가능합니다.");
				return;
			} 			
		}
	     
		if(!(($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != "") || 
			($("#tel_1").val() == "" && $("#tel_2").val() == "" && $("#tel_3").val() == ""))){
		    
			alert("전화번호를 정확히 입력해주십시요");
			$("#tel_1").focus();
			return;
		}
				
		if($("#tel_1").val() != "" && $("#tel_2").val() != "" && $("#tel_3").val() != ""){
			$("#tel").val($("#tel_1").val()+"-"+$("#tel_2").val()+"-"+$("#tel_3").val());
		} else {
			$("#tel").val("");
		}
		
		if(!(($("#fax_1").val() != "" && $("#fax_2").val() != "" && $("#fax_3").val() != "") || 
			($("#fax_1").val() == "" && $("#fax_2").val() == "" && $("#fax_3").val() == ""))){
		    
			alert("팩스번호를 정확히 입력해주십시요");
			$("#fax_1").focus();
			return;
		}
				
		if($("#fax_1").val() != "" && $("#fax_2").val() != "" && $("#fax_3").val() != ""){
			$("#fax").val($("#fax_1").val()+"-"+$("#fax_2").val()+"-"+$("#fax_3").val());
		} else {
			$("#fax").val("");
		}

		$("#cmpyDirUpdateForm").ajaxSubmit({
			success: function(
				responseText, statusText){
					alert(responseText.message);
					if(responseText.success == "true"){
						popupClose();
						selectCmpyDir();
					}	
 				},
 				dataType: "json",
 				data : {
 				},
 				url: $('#homepage_tp').val() + "updateCmpyDir.do"
		});	
	} 
}

//기업디렉토리 삭제
function deleteCmpyDir(){	

	var msg = "승인상태가 “대기”인 기관입니다. 삭제하시겠습니까?";
	var app_stt_cd = $('#app_stt_cd').val();
	if(app_stt_cd == 2) {
		msg = "승인상태가 “승인”된 기관입니다. 삭제하시겠습니까?";
	}
	else if(app_stt_cd == 3) {
		msg = "승잍상태가 “반려”인 기관입니다. 삭제하시겠습니까?"
	}

	if (!confirm(msg)) {
		return;
	}
	
	if ( $("#cmpyDirForm").parsley().validate() ){
		
		$.ajax({
		     url: $('#homepage_tp').val() + "deleteCmpyDir.do",
		     dataType: "json",
		     type: "post",
		     data: jQuery("#cmpyDirForm").serialize(),
		     success: function(data) {		    	 
				alert(data.message);			
				goList();
		     },
		     error: function(e) {
		         alert( '기본정보 데이터를 수정하는데 실패했습니다.' );
		     }
		 });
	} 
}


//기업디렉토리 담당자정보 조회
function selectCmpyDirManager(){
	
	if($('#dir_sn').val() == null || $('#dir_sn').val() == ""){
		return;
	}
	
	$( '#cmpyDirManager' ).html( '' );	
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirManager.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val()
			},
	     success: function(data) {
	     	$( '#cmpyDirManager' ).html( data );
	     },
	     error: function(e) {
	         alert( '담당자정보 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 담당자정보 팝업
function popupCmpyDirManager(_flag){
	
	$( '#pop_contentCmpyDir' ).html( '' );		
	
	$.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirManager.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           myDirectory : $('#myDirectory').val(),
	           popup : "Y"
			},
	     success: function(data) {
	     	$( '#pop_contentCmpyDir' ).html( data );
	     	
	     	var opn_yn = $('#cmpyDirManagerForm #opn_yn').val();
	     	var auth_yn = $('#cmpyDirManagerForm #auth_yn').val();
	     	console.log(_flag + " : " + opn_yn + " : " + auth_yn);
	     	
	     	if(_flag) {
	     		popupShow();
	     	}
	     	else if(auth_yn == 'Y') {
	     		popupShow();
	     	}
	     	else if( auth_yn != 'Y' && opn_yn == 'Y') {
	     		popupShow();
	     	}
	     	else {
	     		alert( '담당자정보을 공개 할수 없습니다.' );	     			
	     	}
	     },
	     error: function(e) {
	         alert( '담당자정보 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 담당자정보 수정
function updateCmpyDirManager(){	

	if ( $("#cmpyDirManagerForm").parsley().validate() ){
		
		var manager_tel_1 = $("#manager_tel_1").val();
		var manager_tel_2 = $("#manager_tel_2").val();
		var manager_tel_3 = $("#manager_tel_3").val();
	     
		if( manager_tel_1 == null || manager_tel_1 == ""){
			alert("휴대폰번호를 정확히 입력해주십시요");
			$("#manager_tel_1").focus();
			return;			
		} 
		if( manager_tel_2 == null || manager_tel_2 == ""){
			alert("휴대폰번호를 정확히 입력해주십시요");
			$("#manager_tel_2").focus();
			return;			
		} 
		if( manager_tel_3 == null || manager_tel_3 == ""){
			alert("휴대폰번호를 정확히 입력해주십시요");
			$("#manager_tel_3").focus();
			return;			
		} 
		
		$("#manager_tel").val(manager_tel_1 + "-" + manager_tel_2 + "-" + manager_tel_3);
		
		var manager_email_1 = $("#manager_email_1").val();
		var manager_email_2 = $("#manager_email_2").val();
	     
		if( manager_email_1 == null || manager_email_1 == ""){
			alert("이메일을 정확히 입력해주십시요");
			$("#manager_email_1").focus();
			return;			
		} 
		if( manager_email_2 == null || manager_email_2 == ""){
			alert("이메일을 정확히 입력해주십시요");
			$("#manager_email_2").focus();
			return;			
		} 
		
		$("#manager_email").val(manager_email_1 + "@" + manager_email_2);
				   	   		   
	   // 데이터를 등록 처리해준다.
		$.ajax({
		     url: $('#homepage_tp').val() + "updateCmpyDirManager.do",
		     dataType: "json",
		     type: "post",
		     data: jQuery("#cmpyDirManagerForm").serialize(),
		     success: function(data) {
		    	 
				alert(data.message);
				
//				if(homepage_tp == '/admin/directory/'){				
					selectCmpyDirManager();
//				}		
				
			    popupClose();
		     },
		     error: function(e) {
		         alert( '담당자정보 데이터를 수정하는데 실패했습니다.' );
		     }
		 });
	} 
}

//기업디렉토리 찾아오시는 길 팝업
function popupCmpyDirMap(){
		
	$( '#pop_contentCmpyDir' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirMap.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           popup : "Y"
			},
	     success: function(data) {
	     	$( '#pop_contentCmpyDir' ).html( data );
        	popupShow();
	     },
	     error: function(e) {
	         alert( '찾아오시는 길 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 찾아오시는 길 수정
function updateCmpyDirMap(){	

	if ( $("#cmpyDirMapForm").parsley().validate() ){
		
	   // 데이터를 등록 처리해준다.
		$.ajax({
		     url: $('#homepage_tp').val() + "updateCmpyDirMap.do",
		     dataType: "json",
		     type: "post",
		     data: jQuery("#cmpyDirMapForm").serialize(),
		     success: function(data) {		    	 
				alert(data.message);			
				selectCmpyDir();				
			    popupClose();
		     },
		     error: function(e) {
		         alert( '찾아오시는 길 데이터를 수정하는데 실패했습니다.' );
		     }
		 });
	} 
}


//기업디렉토리 실적 팝업
function popupCmpyDirBrec(){
	
	$( '#pop_contentCmpyDir' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirBrec.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           popup : "Y"
			},
	     success: function(data) {
	     	$( '#pop_contentCmpyDir' ).html( data );
      	popupShow();
	     },
	     error: function(e) {
	         alert( '실적 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 실적 수정
function updateCmpyDirBrec(){
		
   // 데이터를 등록 처리해준다.
	$.ajax({
	     url: $('#homepage_tp').val() + "updateCmpyDirBrec.do",
	     dataType: "json",
	     type: "post",
	     data: jQuery("#cmpyDirBrecForm").serialize(),
	     success: function(data) {		    	 
			alert(data.message);			
			selectCmpyDir();			
		    popupClose();
	     },
	     error: function(e) {
	         alert( '실적 데이터를 수정하는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 재무현황 조회
function selectCmpyDirFnc(){
	
	if($('#dir_sn').val() == null || $('#dir_sn').val() == ""){
		return;
	}
	
	$( '#cmpyDirFnc' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirFnc.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           limit : 3
			},
	     success: function(data) {
	     	$( '#cmpyDirFnc' ).html( data );
        	setButton('#btn_cmpy_dir_fnc');
	     },
	     error: function(e) {
	         alert( '재무현황 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 재무현황 팝업
function popupCmpyDirFnc(){
	
	$( '#pop_contentCmpyDir' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirFnc.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           popup : "Y"
			},
	     success: function(data) {
	     	$( '#pop_contentCmpyDir' ).html( data );
        	popupShow();
	     },
	     error: function(e) {
	         alert( '재무현황 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 재무현황 수정
function updateCmpyDirFnc(){	

	if ( $("#cmpyDirFncForm").parsley().validate() ){
		
	   // 데이터를 등록 처리해준다.
		$.ajax({
		     url: $('#homepage_tp').val() + "updateCmpyDirFnc.do",
		     dataType: "json",
		     type: "post",
		     data: jQuery("#cmpyDirFncForm").serialize(),
		     success: function(data) {		    	 
				alert(data.message);			
				selectCmpyDirFnc();				
			    popupClose();
		     },
		     error: function(e) {
		         alert( '재무현황 데이터를 수정하는데 실패했습니다.' );
		     }
		 });
	} 
}

//기업디렉토리 수출현황 조회
function selectCmpyDirExp(){
	
	if($('#dir_sn').val() == null || $('#dir_sn').val() == ""){
		return;
	}
	
	$( '#cmpyDirExp' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirExp.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           limit : 3
			},
	     success: function(data) {
	     	$( '#cmpyDirExp' ).html( data );
        	setButton('#btn_cmpy_dir_exp');
	     },
	     error: function(e) {
	         alert( '수출현황 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 수출현황 팝업
function popupCmpyDirExp(){
	
	$( '#pop_contentCmpyDir' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirExp.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           popup : "Y"
			},
	     success: function(data) {
	     	$( '#pop_contentCmpyDir' ).html( data );
        	popupShow();
	     },
	     error: function(e) {
	         alert( '수출현황 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 수출현황 수정
function updateCmpyDirExp(){	

	if ( $("#cmpyDirExpForm").parsley().validate() ){
		$('#update_type').val('cmpyDirExp');
	   // 데이터를 등록 처리해준다.
		$.ajax({
		     url: $('#homepage_tp').val() + "updateCmpyDirExp.do",
		     dataType: "json",
		     type: "post",
		     data: jQuery("#cmpyDirExpForm").serialize(),
		     success: function(data) {		    	 
				alert(data.message);			
				selectCmpyDirExp();				
			    popupClose();
		     },
		     error: function(e) {
		         alert( '수출현황 데이터를 수정하는데 실패했습니다.' );
		     }
		 });
	} 
}

//기업디렉토리 수출현황 수정
function updateCountry(){	

	if ( $("#countryForm").parsley().validate() ){
		
		$("#exp_country").val($('#country').val());
		$("#exp_country_en").val($('#country_en').val());
		$('#update_type').val('country');
	   // 데이터를 등록 처리해준다.
		$.ajax({
		     url: $('#homepage_tp').val() + "updateCmpyDirExp.do",
		     dataType: "json",
		     type: "post",
		     data: jQuery("#cmpyDirExpForm").serialize(),
		     success: function(data) {		    	 
				alert(data.message);			
				selectCmpyDirExp();				
			    popupClose();
		     },
		     error: function(e) {
		         alert( '수출현황 데이터를 수정하는데 실패했습니다.' );
		     }
		 });
	} 
}

//기업디렉토리 인증 및 기술획득 조회
function selectCmpyDirCert(){
	
	if($('#dir_sn').val() == null || $('#dir_sn').val() == ""){
		return;
	}
	
	$( '#cmpyDirCert' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirCert.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val()
			},
	     success: function(data) {
	     	$( '#cmpyDirCert' ).html( data );
        	setButton('#btn_cmpy_dir_cert');
	     },
	     error: function(e) {
	         alert( '인증 및 기술획득 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 인증 및 기술획득 팝업
function popupCmpyDirCert(){
	
	$( '#pop_contentCert' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirCert.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           popup : "Y"
			},
	     success: function(data) {
	     	$( '#pop_contentCert' ).html( data );
	     	
	     	$("#modal-cmpyDirCert").popup('show');
	     },
	     error: function(e) {
	         alert( '인증 및 기술획득 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 인증 및 기술획득 수정
function updateCmpyDirCert(){	

	if ( $("#cmpyDirCertForm").parsley().validate() ){
		
	   // 데이터를 등록 처리해준다.
		$.ajax({
		     url: $('#homepage_tp').val() + "updateCmpyDirCert.do",
		     dataType: "json",
		     type: "post",
		     data: jQuery("#cmpyDirCertForm").serialize(),
		     success: function(data) {		    	 
				alert(data.message);			
				selectCmpyDirCert();				
				$("#modal-cmpyDirCert").popup('hide');
		     },
		     error: function(e) {
		         alert( '인증 및 기술획득 데이터를 수정하는데 실패했습니다.' );
		     }
		 });
	} 
}

//기업디렉토리 연혁 조회
function selectCmpyDirHstr(){
	
	if($('#dir_sn').val() == null || $('#dir_sn').val() == ""){
		return;
	}
	
	$( '#cmpyDirHstr' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirHstr.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val()
			},
	     success: function(data) {
	     	$( '#cmpyDirHstr' ).html( data );
        	setButton('#btn_cmpy_dir_hstr');
	     },
	     error: function(e) {
	         alert( '연혁 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 연혁 팝업
function popupCmpyDirHstr(){
	
	$( '#pop_contentCmpyDir' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirHstr.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           popup : "Y"
			},
	     success: function(data) {
	     	$( '#pop_contentCmpyDir' ).html( data );
        	popupShow();
	     },
	     error: function(e) {
	         alert( '연혁 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 연혁 수정
function updateCmpyDirHstr(){	

	if ( $("#cmpyDirHstrForm").parsley().validate() ){
		
	   // 데이터를 등록 처리해준다.
		$.ajax({
		     url: $('#homepage_tp').val() + "updateCmpyDirHstr.do",
		     dataType: "json",
		     type: "post",
		     data: jQuery("#cmpyDirHstrForm").serialize(),
		     success: function(data) {		    	 
				alert(data.message);			
				selectCmpyDirHstr();				
			    popupClose();
		     },
		     error: function(e) {
		         alert( '연혁 데이터를 수정하는데 실패했습니다.' );
		     }
		 });
	} 
}

//기업디렉토리 주요제품 및 기술현황 조회
function selectCmpyDirPrdt(){
	
	if($('#dir_sn').val() == null || $('#dir_sn').val() == ""){
		return;
	}
	
	$( '#cmpyDirPrdt' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirPrdt.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val()
			},
	     success: function(data) {
	     	$( '#cmpyDirPrdt' ).html( data );
        	setButton('#btn_cmpy_dir_prdt');
	     },
	     error: function(e) {
	         alert( '주요제품 및 기술현황 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 주요제품 및 기술현황 팝업
function popupCmpyDirPrdt(){
	
	$( '#pop_contentCmpyDir' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirPrdt.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           popup : "Y"
			},
	     success: function(data) {
	     	$( '#pop_contentCmpyDir' ).html( data );
        	popupShow();
	     },
	     error: function(e) {
	         alert( '주요제품 및 기술현황 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 주요제품 및 기술현황 수정
function updateCmpyDirPrdt(){	

	if ( $("#cmpyDirPrdtForm").parsley().validate() ){
		
	   // 데이터를 등록 처리해준다.
		$.ajax({
		     url: $('#homepage_tp').val() + "updateCmpyDirPrdt.do",
		     dataType: "json",
		     type: "post",
		     data: jQuery("#cmpyDirPrdtForm").serialize(),
		     success: function(data) {		    	 
				alert(data.message);			
				selectCmpyDirPrdt();				
			    popupClose();
		     },
		     error: function(e) {
		         alert( '주요제품 및 기술현황 데이터를 수정하는데 실패했습니다.' );
		     }
		 });
	} 
}

//기업디렉토리 재품사진 조회
function selectCmpyDirPrdtPctr(){
	
	if($('#dir_sn').val() == null || $('#dir_sn').val() == ""){
		return;
	}
	
	$( '#cmpyDirPrdtPctr' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirPrdtPctr.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           limit : 10
			},
	     success: function(data) {
	     	$( '#cmpyDirPrdtPctr' ).html( data );
        	setButton('#btn_cmpy_dir_prdtPctr');
	     },
	     error: function(e) {
	         alert( '재품사진 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 재품사진 팝업
function popupCmpyDirPrdtPctr(){
	
	$( '#pop_contentCmpyDir' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirPrdtPctr.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           popup : "Y"
			},
	     success: function(data) {
	     	$( '#pop_contentCmpyDir' ).html( data );
	     	
        	popupShow();
	     },
	     error: function(e) {
	         alert( '재품사진 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 재품사진 수정
function updateCmpyDirPrdtPctr(){			
    popupClose();
    selectCmpyDirPrdtPctr();
}

//기업디렉토리 기업동영상 조회
function selectCmpyDirVdo(){
	
	if($('#dir_sn').val() == null || $('#dir_sn').val() == ""){
		return;
	}
	
	$( '#cmpyDirVdo' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirVdo.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           limit : 10
			},
	     success: function(data) {
	     	$( '#cmpyDirVdo' ).html( data );
        	setButton('#btn_cmpy_dir_vdo');
	     },
	     error: function(e) {
	         alert( '기업동영상 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 기업동영상 팝업
function popupCmpyDirVdo(){
	
	$( '#pop_contentCmpyDir' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "selectCmpyDirVdo.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           popup : "Y"
			},
	     success: function(data) {
	     	$( '#pop_contentCmpyDir' ).html( data );
        	popupShow();
	     },
	     error: function(e) {
	         alert( '기업동영상 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 기업동영상 수정
function updateCmpyDirVdo(){	

	if ( $("#cmpyDirVdoForm").parsley().validate() ){
		
	   // 데이터를 등록 처리해준다.
		$.ajax({
		     url: $('#homepage_tp').val() + "updateCmpyDirVdo.do",
		     dataType: "json",
		     type: "post",
		     data: jQuery("#cmpyDirVdoForm").serialize(),
		     success: function(data) {		    	 
				alert(data.message);			
				selectCmpyDirVdo();				
			    popupClose();
		     },
		     error: function(e) {
		         alert( '기업동영상 데이터를 수정하는데 실패했습니다.' );
		     }
		 });
	} 
}

//기업디렉토리 인증하기 팝업
function popupCmpyDirAuth(){
	
	$( '#pop_contentCmpyDir' ).html( '' );		
	
	 $.ajax({
	     url: $('#homepage_tp').val() + "searchCmpyDirAuth.do",
	     dataType: "html",
	     type: "post",
	     data: {
	           dir_sn : $('#dir_sn').val(),
	           lang : $("#lang").val(),
	           popup : "Y"
			},
	     success: function(data) {
	     	$( '#pop_contentCmpyDir' ).html( data );
      	popupShow();
	     },
	     error: function(e) {
	         alert( '인증하기 데이터를 가져오는데 실패했습니다.' );
	     }
	 });
}

//기업디렉토리 인증번호 수정
function checkCmpyDirAuth(){	

	if ( $("#cmpyDirAuthForm").parsley().validate() ){
		
	   // 데이터를 등록 처리해준다.
		$.ajax({
		     url: $('#homepage_tp').val() + "checkCmpyDirAuth.do",
		     dataType: "json",
		     type: "post",
		     data: jQuery("#cmpyDirAuthForm").serialize(),
		     success: function(data) {
		    	 if(data.result == 'none'){
		    		 alert("인증 실패하였습니다.");
		    	 } else {
		    		 $('#myDirectory').val('Y');
		    		 setButton('#btn_cmpy_dir');
//		         	 setButton('#btn_cmpy_dir_manager');
		         	 setButton('#btn_cmpy_dir_brec');
		         	 setButton('#btn_cmpy_dir_map');
		         	 setButton('#btn_cmpy_dir_fnc');
		         	 setButton('#btn_cmpy_dir_exp');
		         	 setButton('#btn_cmpy_dir_cert');
		         	 setButton('#btn_cmpy_dir_hstr');
		         	 setButton('#btn_cmpy_dir_prdt');
		         	 setButton('#btn_cmpy_dir_prdtPctr');
		         	 setButton('#btn_cmpy_dir_vdo');
		         	 setButton('#btn_cmpy_dir_auth');	
					 popupClose();	    		 	         	
		    		 alert("인증 성공하였습니다.");			
		    	 }
		     },
		     error: function(e) {
		         alert( '인증 확인 처리를 실패했습니다.' );
		     }
		 });
	} 
}

//목록으로 
function goList(){
    
	$('#cmpyDirForm > #dir_sn').val('');
	
	var f = document.cmpyDirForm;
	
    f.target = "_self";
    f.action = $('#homepage_tp').val() + "cmpyDirListPage.do",
    f.submit();	
}


// 팝업 열기
function popupShow(){	
	$("#modal-cmpyDir").popup('show');
}


// 팝업 닫기
function popupClose(){
	$("#modal-cmpyDir").popup('hide');
}

//일반적인 상세보기 인지, 본인이 상세보기를 들어온지에 따라서 버튼을 활성화/비활성화 시킨다.
function setButton(button_name){	

	if($('#homepage_tp').val() == '/web/directory/'){	
	
		var myDirectory = $('#myDirectory').val();
		
		if(myDirectory == 'Y'){
			$( button_name ).show(); 
			if(button_name == '#btn_cmpy_dir_auth'){
				$( button_name ).hide();
			}
		} else {
			$( button_name ).hide();   	
			if(button_name == '#btn_cmpy_dir_auth'){
				$( button_name ).show();
			}
		}
	}
}


//이메일 도메인 변경
function changeEmailDomain(){
	var domain = $("#email_domain").val();
	
	if(domain == 'self'){
		$("#manager_email_2").val('');
	} else {
		$("#manager_email_2").val($("#email_domain").val());		
	}
}

$.fn.rowspan = function(colIdx, isStats) {     
	return this.each(function(){        
        var that;       
        $('tr', this).each(function(row) {        
            $('td',this).eq(colIdx).filter(':visible').each(function(col) {  
                if ($(this).html() == $(that).html() && (!isStats || isStats && $(this).prev().html() == $(that).prev().html() ) ) {              
                    rowspan = $(that).attr("rowspan") || 1;  
                    rowspan = Number(rowspan)+1;  
  
                    $(that).attr("rowspan",rowspan);  
                      
                    $(this).hide();  
                      
//                    $(this).remove();   
                    // do your action for the old cell here  
                      
                } else {              
                    that = this;           
                }            
                  
                // set the that if not already set  
                that = (that == null) ? this : that;        
            });       
        });      
    });    
};

function showInitBtn(){
	$('#btnsave').show();
	$('#btn_save').show();
	$("#sub_btn div button").hide();
	
//	$("#sub_btn div button:last").show();
}

function cancel() {
	showInitBtn();
	$('#dataRowTitleDiv').css('display','none');
	$('#dataRowTableDiv').css('display','none');
}

function showInsertBtn(){
	$('#btnsave').hide();
	$('#btn_save').hide();
	$("#sub_btn div button").hide();
	$("#sub_btn div button:first").show();
	$("#sub_btn div button:last").show();
	selectedRow = null;
}

function showUpdateBtn(){
	$('#btnsave').hide();
	$('#btn_save').hide();
	$("#sub_btn div button").show();
	$("#sub_btn div button:first").hide();
}
