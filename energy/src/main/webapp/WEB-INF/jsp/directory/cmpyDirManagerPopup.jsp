<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script language="javascript">
</script>

		
<form id="cmpyDirManagerForm" name="cmpyDirManagerForm" method="post" onsubmit="return false;">
					
	<input type='hidden' id="dir_sn" name='dir_sn' value="${param.dir_sn}" /> 
	<input type='hidden' id="manager_tel" name='manager_tel' value="${cmpyDir.manager_tel}" />
	<input type='hidden' id="manager_email" name='manager_email' value="${cmpyDir.manager_email}" />
	<input type='hidden' id="opn_yn" name="opn_yn" value="${cmpyDir.manager_opn_yn}" />
	<input type='hidden' id="auth_yn" name="auth_yn" value="${param.myDirectory}" />

	<div id="wrap">
	
		<!-- header -->
		<div id="pop_header">
		<header>
			<h1 class="pop_title">
				<c:if test="${param.lang == 'en'}">
				Manager Information
				</c:if>
				<c:if test="${param.lang != 'en'}">
				담당자정보
				</c:if>
			</h1>
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
			
				<!-- pop_content -->
				<div id="pop_content">
				
					<!-- dtitle_area -->
					<div class="dtitle_area">
						<div class="float_left padt5">
							<h2 class="title">
								<c:if test="${param.lang == 'en'}">
								Manager Information
								</c:if>
								<c:if test="${param.lang != 'en'}">
								담당자정보
								</c:if>
							</h2>
						</div>
					</div>
					<!--// dtitle_area -->
					
					<!-- dtable_area -->
					<div class="dtable_area">
						<table class="dtable">
							<caption>기본정보 화면</caption>
							<colgroup>
								<col style="width: 180px;" />
								<col style="width: *;" />
							</colgroup>
							<tbody>
							<c:if test="${param.myDirectory == 'Y'}">
								<tr>
									<th scope="row" class="first">
										<label for="manager_nm">
											<strong class="color_pointr">*</strong>이름(국문)
										</label>									
									</th>
									<td class="last">
										<input type="text" name="manager_nm" id="manager_nm" class="in_w30" value="${cmpyDir.manager_nm}" data-parsley-maxlength="30" data-parsley-required="true" />
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">
										<label for="manager_nm_en">
											<strong class="color_pointr">*</strong>이름(영문)
										</label>									
									</th>
									<td class="last">
										<input type="text" name="manager_nm_en" id="manager_nm_en" class="in_w30" value="${cmpyDir.manager_nm_en}" data-parsley-maxlength="30" data-parsley-required="true" />
									</td>
								</tr>
							</c:if>
							<c:if test="${param.myDirectory != 'Y'}">
								<tr>
									<th scope="row" class="first">
										<label for="manager_nm">
											<c:if test="${param.lang == 'en'}">
												<strong class="color_pointr">*</strong>Name(English)
											</c:if>
											<c:if test="${param.lang != 'en'}">
												<strong class="color_pointr">*</strong>이름(국문)
											</c:if>
										</label>									
									</th>
									<td class="last">
										<c:if test="${param.lang == 'en'}">
											${cmpyDir.manager_nm_en}
										</c:if>
										<c:if test="${param.lang != 'en'}">
											${cmpyDir.manager_nm}
										</c:if>
									</td>
								</tr>
							</c:if>
							<c:if test="${param.myDirectory == 'Y'}">
								<tr>
									<th scope="row" class="first">
										<strong class="color_pointr">*</strong>휴대전화
									</th>
									<td class="last">
										<label for="manager_tel_1" class="hidden">휴대전화 앞자리 선택</label>
										<select class="in_wp100" id="manager_tel_1" name="manager_tel_1" data-parsley-errors-container="#errMsgManagerTel" data-parsley-required="true">
											<option value="010" <c:if test="${cmpyDir.manager_tel_1 eq '010'}">selected</c:if> >010</option>
											<option value="011" <c:if test="${cmpyDir.manager_tel_1 eq '011'}">selected</c:if> >011</option>
											<option value="016" <c:if test="${cmpyDir.manager_tel_1 eq '016'}">selected</c:if> >016</option>
											<option value="017" <c:if test="${cmpyDir.manager_tel_1 eq '017'}">selected</c:if> >017</option>
											<option value="018" <c:if test="${cmpyDir.manager_tel_1 eq '018'}">selected</c:if> >018</option>
										</select>
										
										<label for="manager_tel_2" class="hidden">휴대전화 중간자리 입력</label>
										<input type="text" id="manager_tel_2" name="manager_tel_2" class="in_wp100" value="${cmpyDir.manager_tel_2}" maxlength="4" data-parsley-errors-container="#errMsgManagerTel" data-parsley-required="true" />
										
										<label for="manager_tel_3" class="hidden">휴대전화 마지막자리 입력</label>
										<input type="text" id="manager_tel_3" name="manager_tel_3" class="in_wp100" value="${cmpyDir.manager_tel_3}" maxlength="4" data-parsley-errors-container="#errMsgManagerTel" data-parsley-required="true" />
										<div class="parsely-single-error" id="errMsgManagerTel" />
									</td>
								</tr>
							</c:if>
							<c:if test="${param.myDirectory != 'Y'}">
								<tr>
									<th scope="row" class="first">
										<label for="manager_nm">
											<c:if test="${param.lang == 'en'}">
												<strong class="color_pointr">*</strong>TEL
											</c:if>
											<c:if test="${param.lang != 'en'}">
												<strong class="color_pointr">*</strong>휴대전화
											</c:if>
										</label>									
									</th>
									<td class="last">
										${cmpyDir.manager_tel_1} - ${cmpyDir.manager_tel_2} - ${cmpyDir.manager_tel_3}
									</td>
								</tr>
							</c:if>
							<c:if test="${param.myDirectory == 'Y'}">
								<tr>
									<th scope="row" class="first">
										<strong class="color_pointr">*</strong>이메일
									</th>
									<td class="last">
										<label for="manager_email_1" class="hidden">이메일 앞주소</label>
										<input type="text" class="in_wp100" id="manager_email_1" name="manager_email_1" value="${cmpyDir.manager_email_1}" data-parsley-maxlength="30" data-parsley-required="true" data-parsley-errors-container="#email_error_message" />
										
										<span class="marginr5 marginl5">@</span>
										
										<label for="manager_email_2" class="hidden">이메일 마지막 주소 입력</label>
										<input type="text" class="in_wp100" id="manager_email_2" name="manager_email_2" value="${cmpyDir.manager_email_2}" data-parsley-maxlength="30" data-parsley-required="true" data-parsley-errors-container="#email_error_message" />
										
										<label for="email_domain" class="hidden">이메일 마지막 주소 선택</label>
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
							</c:if>
							<c:if test="${param.myDirectory != 'Y'}">
								<tr>
									<th scope="row" class="first">
										<c:if test="${param.lang == 'en'}">
											<strong class="color_pointr">*</strong>E-Mail
										</c:if>
										<c:if test="${param.lang != 'en'}">
											<strong class="color_pointr">*</strong>이메일
										</c:if>
									</th>
									<td class="last">
										${cmpyDir.manager_email_1}@${cmpyDir.manager_email_2}
									</td>
								</tr>
							</c:if>
							<c:if test="${param.myDirectory == 'Y'}">
								<tr>
									<th scope="row" class="first">
										<label for="manager_dept">
											<strong class="color_pointr">*</strong>부서(국문)
										</label>
									</th>
									<td class="last">
										<input type="text" class="in_w30" name="manager_dept" id="manager_dept" class="in_wp200" value="${cmpyDir.manager_dept}" data-parsley-maxlength="300" data-parsley-required="true" />
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">
										<label for="manager_dept_en">
											<strong class="color_pointr">*</strong>부서(영문)
										</label>
									</th>
									<td class="last">
										<input type="text" class="in_w30" name="manager_dept_en" id="manager_dept_en" class="in_wp200" value="${cmpyDir.manager_dept_en}" data-parsley-maxlength="300" data-parsley-required="true" />
									</td>
								</tr>
							</c:if>
							<c:if test="${param.myDirectory != 'Y'}">
								<tr>
									<th scope="row" class="first">
										<label for="manager_dept">
											<c:if test="${param.lang == 'en'}">
												<strong class="color_pointr">*</strong>Department(English)
											</c:if>
											<c:if test="${param.lang != 'en'}">
												<strong class="color_pointr">*</strong>부서(국문)
											</c:if>
										</label>
									</th>
									<td class="last">
										<c:if test="${param.lang == 'en'}">
											${cmpyDir.manager_dept_en}
										</c:if>
										<c:if test="${param.lang != 'en'}">
											${cmpyDir.manager_dept}
										</c:if>
									</td>
								</tr>
							</c:if>
							<c:if test="${param.myDirectory == 'Y'}">
								<tr>
									<th scope="row" class="first">공개여부</th>
									<td class="last">																	
										<input type="radio" name="manager_opn_yn" id="manager_opn_yn_y" class="" value="Y" <c:if test="${cmpyDir.manager_opn_yn eq 'Y'}">checked="checked"</c:if> />
										<label for="manager_opn_yn_y" class="marginr10">공개</label>	
										<input type="radio" name="manager_opn_yn" id="manager_opn_yn_n" class="marginl10" value="N" <c:if test="${cmpyDir.manager_opn_yn ne 'Y'}">checked="checked"</c:if> />
										<label for="manager_opn_yn_n">비공개</label>
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">뉴스레터</th>
									<td class="last">
										<input type="radio" name="newsltr_rcv_yn" id="newsltr_rcv_yn_y" class="" value="Y" <c:if test="${cmpyDir.newsltr_rcv_yn eq 'Y'}">checked="checked"</c:if> />
										<label for="newsltr_rcv_yn_y" class="marginr10">예</label>
										<input type="radio" name="newsltr_rcv_yn" id="newsltr_rcv_yn_n" class="marginl10" value="N" <c:if test="${cmpyDir.newsltr_rcv_yn ne 'Y'}">checked="checked"</c:if> />
										<label for="newsltr_rcv_yn_n">아니오</label>									
									</td>
								</tr>
							</c:if>
							<c:if test="${param.myDirectory != 'Y'}">
								<tr>
									<th scope="row" class="first">
										<c:if test="${param.lang == 'en'}">
											Visibility
										</c:if>
										<c:if test="${param.lang != 'en'}">
											공개여부
										</c:if>
									</th>
									<td class="last">
										<c:if test="${param.lang == 'en' && cmpyDir.manager_opn_yn eq 'Y'}">
											Open
										</c:if>
										<c:if test="${param.lang == 'en' && cmpyDir.manager_opn_yn ne 'Y'}">
											Private
										</c:if>
										<c:if test="${param.lang != 'en' && cmpyDir.manager_opn_yn eq 'Y'}">
											공개
										</c:if>
										<c:if test="${param.lang != 'en' && cmpyDir.manager_opn_yn ne 'Y'}">
											비공개
										</c:if>
									</td>
								</tr>
								<tr>
									<th scope="row" class="first">
										<c:if test="${param.lang == 'en'}">
											Newsletters
										</c:if>
										<c:if test="${param.lang != 'en'}">
											뉴스레터
										</c:if>
									</th>
									<td class="last">
										<c:if test="${param.lang == 'en' && cmpyDir.newsltr_rcv_yn eq 'Y'}">
											Yes
										</c:if>
										<c:if test="${param.lang == 'en' && cmpyDir.newsltr_rcv_yn ne 'Y'}">
											No
										</c:if>
										<c:if test="${param.lang != 'en' && cmpyDir.newsltr_rcv_yn eq 'Y'}">
											예
										</c:if>
										<c:if test="${param.lang != 'en' && cmpyDir.newsltr_rcv_yn ne 'Y'}">
											아니요
										</c:if>
									</td>
								</tr>
							</c:if>
							</tbody>
						</table>
					</div>
					<!--// dtable_area -->
				</div>
				
				<!--// pop_content -->
			</div>
		</article>	
		</div>
		<!-- //container -->
	
		<!-- footer --> 
		<div id="pop_footer">
		<footer>
		
			<!-- dbutton_area -->
			<div class="dbutton_area alignr marginr10">
				<c:if test="${param.myDirectory == 'Y'}">
					<button class="btn save" title="저장" onclick="javascript:updateCmpyDirManager()">
						<span>저장</span>
					</button>
				</c:if>
				<button class="btn cancel" title="취소" onClick="javascript:popupClose()">
					<c:if test="${param.lang == 'en'}">
						<span>cancel</span>
					</c:if>
					<c:if test="${param.lang != 'en'}">
						<span>취소</span>
					</c:if>
				</button>
			</div>
			<!--// dbutton_area -->
			
		</footer>
		</div>
		<!-- //footer -->
		
	</div>

</form>