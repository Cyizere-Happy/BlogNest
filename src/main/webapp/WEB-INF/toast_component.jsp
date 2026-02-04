<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/toast.css">

        <%-- This script checks both request and session attributes for toast messages --%>
            <c:set var="tType"
                value="${not empty requestScope.toastType ? requestScope.toastType : sessionScope.toastType}" />
            <c:set var="tTitle"
                value="${not empty requestScope.toastTitle ? requestScope.toastTitle : sessionScope.toastTitle}" />
            <c:set var="tMsg"
                value="${not empty requestScope.toastMessage ? requestScope.toastMessage : sessionScope.toastMessage}" />

            <c:if test="${not empty tType}">
                <div id="server-toast-data" style="display:none;" data-type="${tType}" data-title="${tTitle}"
                    data-message="${tMsg}">
                </div>

                <%-- Clear session attributes if they were used --%>
                    <c:if test="${not empty sessionScope.toastType}">
                        <c:remove var="toastType" scope="session" />
                        <c:remove var="toastTitle" scope="session" />
                        <c:remove var="toastMessage" scope="session" />
                    </c:if>
            </c:if>

            <script src="${pageContext.request.contextPath}/js/toast.js"></script>