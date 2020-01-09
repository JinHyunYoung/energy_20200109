<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<%@ page import="kr.or.wabis.framework.util.ProjectConfigUtil"%> 

<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />

<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<title><%=(String)ProjectConfigUtil.getProperty("project.site.name") %></title>
		
		<link rel="stylesheet" type="text/css" href="/css/web/default.css" />
		<link rel="stylesheet" type="text/css" href="/css/web/common.css" />
		<link rel="stylesheet" type="text/css" href="/css/web/table.css" />
		<link rel="stylesheet" type="text/css" href="/css/web/popup.css" />
		<link rel="stylesheet" type="text/css" href="/css/web/calendar.css" />
		<link rel="stylesheet" type="text/css" href="/css/web/nanumgothic.css" />
		
		<!--[if lt IE 9]>
			<script type="text/javascript" src="/assets/html5.js"></script>
		<![endif]-->
		
		<script type="text/javascript" src="/assets/jquery/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="/assets/jquery/jquery.form.js"></script>
		<script type="text/javascript" src="/assets/jquery/jquery.popupoverlay.js"></script>
		<script type="text/javascript" src="/assets/jquery-ui/ui/minified/jquery-ui.min.js"></script>
		
		<script type="text/javascript" src="/assets/bootstrap/js/bootstrap.js"></script>
		
		<script type="text/javascript" src="/assets/jqgrid/i18n/grid.locale-kr.js"></script>
		<script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.js"></script>
		<script type="text/javascript" src="/assets/jqgrid/jquery.jqGrid.ext.js"></script>
		<script type="text/javascript" src="/assets/jqgrid/jquery.loadJSON.js"></script>
		<script type="text/javascript" src="/assets/jqgrid/jquery.tablednd.js"></script>
		
		<script type="text/javascript" src="/assets/parsley/dist/parsley.js"></script>
		<script type="text/javascript" src="/assets/parsley/dist/i18n/ko.js"></script>
		
		<script type="text/javascript" src="/js/cms.js"></script>	
		
		<script language="javascript">
		
		$(function(){
		    
		    //전송버튼 클릭이벤트
		    $("#saveBtn").click(function() {
			
		        if (!$.trim($('#pass').val())) {
		            alert('비밀번호를 입력해주세요');
		            $('#pass').focus();
		            return;
		        }
		        
		        opener.passchk($('#pass').val());
		        closePopup();
		        
		    });
		});
		
		function closePopup(){
			window.close();
		}
		
		</script>	
	</head>

	<body>
	<div id="wrap">
		
		<!-- popup_content -->
		
		<!-- header -->
		<div id="pop_header">
		
		<header>
			<h1 class="pop_title">비밀번호</h1>
			<a href="javascript:closePopup()" class="pop_close" title="페이지 닫기">
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
					
						<!-- table_area -->
						<div class="table_area">
						
							<table class="write fixed">
								<caption>개인정보 등록 화면</caption>
								<colgroup>
									<col style="width: 150px;">
									<col style="width: *;">
								</colgroup>
								<tbody>
								<tr>
									<th scope="row" class="first">
										<label for="input_password">
											<strong class="color_pointr">*</strong>비밀번호
										</label>
									</th>
									<td class="first">
										<input type="password" class="in_w100" id="pass" name="pass" />
									</td>
								</tr>
								</tbody>
							</table>
						</div>
						<!--// table_area -->
						
						<!-- button_area -->
						<div class="button_area">
			            	<div class="alignc">
			            		<button id="saveBtn" class="btn save" title="확인">
			            			<span>확인</span>
			            		</button>
			            	</div>
			            </div>
			            <!--// button_area -->
			            
					</div>
				</div>
			</article>	
		</div>
		<!--// popup_content -->		
		
	</div>
	</body>
</html>
