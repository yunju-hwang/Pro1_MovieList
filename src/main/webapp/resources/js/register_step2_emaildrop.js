$(function () {
    // 기본적으로 "직접 입력"이 선택되어 있어야 하므로, 이메일 도메인 입력 필드를 활성화
    $('#emailDomain').prop('disabled', false);

    // 이메일 도메인 선택 시 도메인 입력 필드를 활성화/비활성화
    $('#emailDomainSelect').on('change', function () {
        const selectedDomain = $(this).val();
        const emailDomainInput = $('#emailDomain');
        const emailIdInput = $('#emailId');

        if (selectedDomain === "") {
            // "직접 입력" 선택 시 이메일 도메인 입력란 활성화
            emailDomainInput.prop('disabled', false);
            emailDomainInput.val('');  // 입력란 비워줌
        } else {
            // 도메인 선택 시, 입력란 비활성화하고 도메인 값으로 자동 완성
            emailDomainInput.prop('disabled', true);
            emailDomainInput.val(selectedDomain);
            updateEmail(emailIdInput, emailDomainInput);
        }
    });

    // 이메일 아이디나 도메인이 변경될 때마다 이메일을 업데이트
    $('#emailId, #emailDomain').on('input', function () {
        const emailIdInput = $('#emailId');
        const emailDomainInput = $('#emailDomain');
        updateEmail(emailIdInput, emailDomainInput);
    });

    // 이메일 자동 업데이트 함수
    function updateEmail(emailIdInput, emailDomainInput) {
        const emailId = emailIdInput.val().trim();
        const emailDomain = emailDomainInput.val().trim();

        if (emailId && emailDomain) {
            const email = emailId + '@' + emailDomain;
            $('#email').val(email);  // #email 필드에 이메일 값 저장
            $('#emailError').text("");  // 오류 메시지 초기화
            validateEmail(email); // 유효성 검사
        }
    }

    // 이메일 유효성 검사
    function validateEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            $('#emailError').text("올바른 이메일 형식이 아닙니다.").css("color", "red");
        } else {
            $('#emailError').text("올바른 이메일입니다.").css("color", "green");
        }
    }

    // 페이지 로딩 시, 기본적으로 "직접 입력"이 선택되었을 때 입력란을 활성화
    if ($('#emailDomainSelect').val() === "") {
        $('#emailDomain').prop('disabled', false); // "직접 입력" 선택 시
    }
});
