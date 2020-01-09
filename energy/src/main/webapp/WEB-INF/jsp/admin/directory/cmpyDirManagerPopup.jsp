<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/admin/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g"%>

<script language="javascript">
</script>
					
<form id="cmpyDirManagerForm" name="cmpyDirManagerForm" method="post" onsubmit="return false;">
	
	<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" /> 
	<input type='hidden' id="manager_tel" name='manager_tel' value="${cmpyDir.manager_tel}" />
	<input type='hidden' id="manager_email" name='manager_email' value="${cmpyDir.manager_email}" />
			
	<div id="wrap">
		
		<!-- popup_content -->
		
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 class="pop_title">담당자 정보</h1>
			<a href="javascript:popupClose()" class="pop_close" title="페이지 닫기">
				<span>닫기</span>
			</a>
		</header>
		</div>
		<!-- //header -->		
		
		<!-- container -->
		<div id="pop_container">
		<article>
			<div class="pop_content_area">
				<div id="pop_content">
				
					<!-- division -->
					<div class="division">
												
						<!-- table_area -->
						<div class="table_area">
	
							<table class="write">
								<caption>담당자 정보 수정 화면</caption>
								<colgroup>
									<col style="width: 140px;">
									<col style="width: *;">
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">
										<label for="input_name_kor">이름(국문)<strong class="color_pointr">*</strong></label>
									</th>
									<td>
										<input type="text" name="manager_nm" id="manager_nm" class="in_wp200" value="${cmpyDir.manager_nm}" data-parsley-maxlength="30" data-parsley-required="true" />
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="input_name_eng">이름(영문)<strong class="color_pointr">*</strong></label>
									</th>
									<td>
										<input type="text" name="manager_nm_en" id="manager_nm_en" class="in_wp200" value="${cmpyDir.manager_nm_en}" data-parsley-maxlength="30" data-parsley-required="true" />
									</td>
								</tr>
								<tr>
									<th scope="row">
										휴대전화<strong class="color_pointr">*</strong>
									</th>
									<td>
										<label for="manager_tel_1" class="hidden">휴대전화 앞번호 선택</label>
										<select id="manager_tel_1" name="manager_tel_1" class="in_wp80" data-parsley-errors-container="#errMsgManagerTel" data-parsley-required="true" >	
											<option value="010" <c:if test="${cmpyDir.manager_tel_1 eq '010'}">selected</c:if> >010</option>
											<option value="011" <c:if test="${cmpyDir.manager_tel_1 eq '011'}">selected</c:if> >011</option>
											<option value="016" <c:if test="${cmpyDir.manager_tel_1 eq '016'}">selected</c:if> >016</option>
											<option value="017" <c:if test="${cmpyDir.manager_tel_1 eq '017'}">selected</c:if> >017</option>
											<option value="018" <c:if test="${cmpyDir.manager_tel_1 eq '018'}">selected</c:if> >018</option>
										</select> - 
										
										<label for="manager_tel_2" class="hidden">휴대전화 중간번호 입력</label>
										<input type="text" id="manager_tel_2" name="manager_tel_2" value="${cmpyDir.manager_tel_2}" class="in_wp100" maxlength="4" data-parsley-errors-container="#errMsgManagerTel" data-parsley-required="true" /> - 
										
										<label for="manager_tel_3" class="hidden">휴대전화 뒷번호 입력</label>
										<input type="text" id="manager_tel_3" name="manager_tel_3" value="${cmpyDir.manager_tel_3}" class="in_wp100" maxlength="4" data-parsley-errors-container="#errMsgManagerTel" data-parsley-required="true" />
										<div class="parsely-single-error" id="errMsgManagerTel" />
									</td>
								</tr>
								<tr>
									<th scope="row">
										이메일<strong class="color_pointr">*</strong>
									</th>
									<td>
										<label for="manager_email_1" class="hidden">이메일 앞주소</label>
										<input type="text" id="manager_email_1" name="manager_email_1" value="${cmpyDir.manager_email_1}" class="in_wp100" maxlength="30" data-parsley-errors-container="#email_error_message" data-parsley-required="true"/> @ 
										
										<label for="manager_email_2" class="hidden">이메일 뒷주소</label>
										<input type="text" id="manager_email_2" name="manager_email_2" value="${cmpyDir.manager_email_2}" class="in_wp120" maxlength="30" data-parsley-errors-container="#email_error_message" data-parsley-required="true"/>
										
										<label for="email_domain" class="hidden">이메일 뒷주소 선택</label>
										<select id="email_domain" name="email_domain" onChange="changeEmailDomain()" class="in_wp120">
											<option value="self">직접입력</option>
											<option value="hanmail.net">한메일</option>
											<option value="naver.com">네이버</option>
											<option value="nate.com">네이트</option>
											<option value="gmail.com">구글</option>
											<option value="yahoo.co.kr">야후</option>
											<option value="lycos.co.kr">라이코스</option>
											<option value="chollian.net">천리안</option>
											<option value="empal.com">엠팔</option>
											<option value="hotmail.com">핫메일</option>
											<option value="dreamwiz.com">드림위즈</option>
											<option value="paran.com">파란</option>
										</select>
										<div class="parsely-single-error" id="email_error_message"></div>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="manager_dept">부서(국문)<strong class="color_pointr">*</strong></label>
									</th>
									<td>
										<input type="text" name="manager_dept" id="manager_dept" class="in_wp200" value="${cmpyDir.manager_dept}" data-parsley-maxlength="300" data-parsley-required="true" />
									</td>
								</tr>
								<tr>
									<th scope="row">
										<label for="input_group_eng">부서(영문)<strong class="color_pointr">*</strong></label>
									</th>
									<td>
										<input type="text" name="manager_dept_en" id="manager_dept_en" class="in_wp200" value="${cmpyDir.manager_dept_en}" data-parsley-maxlength="300" data-parsley-required="true" />
									</td>
								</tr>
								<tr>
									<th scope="row">
										공개여부
									</th>
									<td>							
										<input type="radio" name="manager_opn_yn" id="manager_opn_yn_y" class="" value="Y" <c:if test="${cmpyDir.manager_opn_yn eq 'Y'}">checked="checked"</c:if> />
										<label for="manager_opn_yn_y">공개</label>		
										<input type="radio" name="manager_opn_yn" id="manager_opn_yn_n" class="marginl10" value="N" <c:if test="${cmpyDir.manager_opn_yn ne 'Y'}">checked="checked"</c:if> />
										<label for="manager_opn_yn_n">비공개</label>
									</td>
								</tr>
								<tr>
									<th scope="row">
										뉴스레터 수신여부
									</th>
									<td>
										<input type="radio" name="newsltr_rcv_yn" id="newsltr_rcv_yn_y" class="marginl10" value="Y" <c:if test="${cmpyDir.newsltr_rcv_yn eq 'Y'}">checked="checked"</c:if> />
										<label for="newsltr_rcv_yn_y">예</label>
										<input type="radio" name="newsltr_rcv_yn" id="newsltr_rcv_yn_n" class="marginl10" value="N" <c:if test="${cmpyDir.newsltr_rcv_yn ne 'Y'}">checked="checked"</c:if> />
										<label for="newsltr_rcv_yn_n">아니오</label>
									</td>
								</tr>
								</tbody>
							</table>
						</div>
						<!--// table_area -->
						
						<!-- button_area -->
						<div class="button_area">
							<div class="float_right">
								<button class="btn save" title="저장" onclick="javascript:updateCmpyDirManager()">
									<span>저장</span>
								</button>
								<button class="btn cancel" title="취소" onclick="javascript:popupClose()">
									<span>취소</span>
								</button>
							</div>
						</div>
						<!--// button_area -->
						
					</div>
					<!--// division -->
					
				</div>
			</div>
		</article>	
		</div>
		<!--// popup_content -->		
		
	</div>
						
</form>