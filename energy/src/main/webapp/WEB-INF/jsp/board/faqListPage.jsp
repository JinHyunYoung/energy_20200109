<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script type="text/javascript" src="/js/faq.js"></script>

<script language="javascript">

$(document).ready(function(){
	//토글버튼
	$("[id^=faq_]").click(function(){
		if($(this).children().hasClass('btn_open')){
			$(this).next().show();
			$(this).children().removeClass('btn_open');
			$(this).children().addClass('btn_fold');
		}else{
			$(this).next().hide();
			$(this).children().removeClass('btn_fold');
			$(this).children().addClass('btn_open');
		}
		
	});
	
	if("${not empty param.faq_id}"){
		$("#faq_${param.faq_id}").trigger("click");
	}
	
});

function openClseBtn(arg){
	event.stopPropagation();
	$("#"+arg).trigger("click");
}

</script>

<!-- faq_area --> 
<div class="ndivision">

	<dl class="faqs">
	
		<!-- contentsList -->
		<c:forEach items="${faqList }" var="list" varStatus="i">
			<dt id="faq_${list.faq_id }">${list.title }<a tabindex=”” title="접기/펼치기 버튼" class="btn_open" href="javascript:openClseBtn('faq_${list.faq_id }');"></a></dt>
			<dd style="display:none">
				<div class="details">
					<p>${list.contents }</p>
				</div>
			</dd>
		</c:forEach>
		<!-- //contentsList -->
		
	</dl>
</div>
	
