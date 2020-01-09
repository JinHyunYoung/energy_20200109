<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/taglib.tld" prefix="g" %>

<script type="text/javascript" src="/js/cms.js"></script>

 <div class="section">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
                 ${infopage.contents}
           </div>
		</div>
	</div>
</div>
<a href="javascript:window.close()">[닫기]</a>
    