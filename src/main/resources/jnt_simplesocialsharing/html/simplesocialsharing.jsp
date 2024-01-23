<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<template:addResources type="css" resources="socialsharing.css" />
<jcr:nodeProperty node="${currentNode}"
                  name="socialSharingTitle" var="title" />

<div class="content-center">
<h5>${title}</h5>
<ul class="social">
    <c:forEach items="${currentNode.properties.socialNetworks}" var="socialNetwork">
        <li>
            <%--Retrieve the parent page--%>
            <c:set var="parentPage" value="${jcr:getParentOfType(currentNode, 'jnt:page')}"/>
            <c:url var="parentPageUrl" value="${url.baseLive}${parentPage.path}.html"/>
            <c:set var="parentPageFullUrl" value="${url.server}${parentPageUrl}"/>
            <c:set var="parentPageTitle" value="${parentPage.properties['jcr:title'].string}"/>

            <%--Generate the share url with the parent page link--%>
            <fmt:message key="${socialNetwork}.url.share" var="shareUrl"/>
                <c:set var="shareUrl" value="${fn:replace(shareUrl,'[url]',parentPageFullUrl)}"/>
            <c:set var="shareUrl" value="${fn:replace(shareUrl,'[title]',parentPageTitle)}"/>
            <c:url var="shareUrl" value="${shareUrl}" />
            ${currentNode.properties['jcr:title'].string}
                <a href="${shareUrl}" rel="nofollow" title="share this page on ${socialNetwork}">
                    <i class="fa fa-${socialNetwork} fa-2x"></i>
                </a>
        </li>
    </c:forEach>
</ul>
</div>