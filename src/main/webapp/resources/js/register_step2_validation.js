$(function () {

    /* ----------------------------------------
       01. 생년월일 오늘까지만 선택 가능
    ---------------------------------------- */
    let today = new Date().toISOString().split('T')[0];
    $('#birthDate').attr('max', today);

    /* 생년월일 선택 시 메시지 */
    $('#birthDate').on('change', function () {
        if ($(this).val().trim().length > 0) {
            $('#birthDateError').text("생년월일이 선택 되었습니다.").css("color", "green");
        }
    });

    /* 성별 선택 시 메시지 */
    $('input[name="gender"]').on('change', function () {
        $('#genderError').text("성별이 선택 되었습니다.").css("color", "green");
    });

/* ----------------------------------------
   02. 이름 실시간 검증 (한글/영문 조건 변경)
---------------------------------------- */
$('#username').on('input', function () {
    let username = $(this).val().trim();

    if (username.length === 0) {
        $('#usernameError').text("이름을 입력해주세요.").css("color", "red");
        return;
    }

    // 한글 최소 2글자, 영문 최소 4글자, 최대 35글자
    let hangulRegex = /^[가-힣]{2,35}$/;
    let englishRegex = /^[a-zA-Z]{4,35}$/;

    if (hangulRegex.test(username)) {
        $('#usernameError').text("사용 가능한 이름입니다.").css("color", "green");
    } else if (englishRegex.test(username)) {
        $('#usernameError').text("사용 가능한 이름입니다.").css("color", "green");
    } else {
        $('#usernameError').text("한글은 최소 2글자, 영문 최소 4글자 이상 입력해주세요.").css("color", "red");
    }
});


    /* ----------------------------------------
       03. 아이디 실시간 검증
    ---------------------------------------- */
    $('#user_id').on('input', function () {
        let userId = $(this).val().trim();
        let idRegex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{6,12}$/;

        if (userId.length === 0) {
            $('#userIdError').text("아이디를 입력해주세요.").css("color", "red");
            $('#password').prop('disabled', true);
            $('#user_idChecked').val('false');
            return;
        } else if (!idRegex.test(userId)) {
            $('#userIdError').text("영문 소문자와 숫자를 포함한 6~12자리로 입력하세요.").css("color", "red");
            $('#password').prop('disabled', true);
        } else {
            $('#userIdError').text("사용 가능한 아이디입니다. 중복 확인을 해주세요.").css("color", "blue");
            $('#password').prop('disabled', false);
        }

        $('#user_idChecked').val('false');
    });



    /* ----------------------------------------
       04. 아이디 중복 확인
    ---------------------------------------- */
    $('#check-btn').click(function () {
        let userId = $('#user_id').val().trim();
        let idRegex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{6,12}$/;

        if (userId.length === 0) {
            $('#userIdError').text("아이디를 입력하세요.").css("color", "red");
            $('#user_id').focus();
            return;
        }

        if (!idRegex.test(userId)) {
            $('#userIdError').text("영문 소문자와 숫자를 포함한 6~12자리로 입력하세요.").css("color", "red");
            $('#user_id').focus();
            return;
        }

        $.ajax({
            method: "GET",
            url: contextPath + "/register/idCheck",
            data: { user_id: userId },
            dataType: "json",
            success: function (result) {
                if (result === true) {
                    $('#userIdError').text("이미 사용 중인 아이디입니다.").css("color", "red");
                    $('#user_idChecked').val('false');
                } else {
                    $('#userIdError').text("사용 가능한 아이디입니다.").css("color", "green");
                    $('#user_idChecked').val('true');
                }
            },
            error: function () {
                alert("아이디 확인 중 오류 발생");
                $('#user_idChecked').val('false');
            }
        });
    });

/* ----------------------------------------
   05. 비밀번호 검증 (3개 이상 동일 문자 금지)
---------------------------------------- */
$('#password').on('input', function () {
    let password = $(this).val().trim();
    // 6~12자리 소문자+숫자, 동일 문자 3회 이상 반복 금지
    let passwordRegex = /^(?=.*[a-z])(?=.*[0-9])(?!.*([a-z0-9])\1\1)[a-z0-9]{6,12}$/;

    if (password.length === 0) {
        $('#passwordError').text("비밀번호를 입력해주세요.").css("color", "red");
        $('#passwordCheck').prop('disabled', true);
        return;
    } else if (!passwordRegex.test(password)) {
        $('#passwordError').text("비밀번호는 6~12자 소문자/숫자 조합이며, 3개이상 동일 문자/숫자 입력 불가입니다.").css("color", "red");
        $('#passwordCheck').prop('disabled', true);
    } else {
        $('#passwordError').text("사용 가능한 비밀번호입니다.").css("color", "green");
        $('#passwordCheck').prop('disabled', false);
    }
});


    /* ----------------------------------------
       06. 비밀번호 확인
    ---------------------------------------- */
    $('#passwordCheck').on('input', function () {
        let password = $('#password').val().trim();
        let passwordCheck = $(this).val().trim();

        if (passwordCheck.length === 0) {
            $('#passwordCheckError').text("");
        } else if (password !== passwordCheck) {
            $('#passwordCheckError').text("비밀번호가 일치하지 않습니다.").css("color", "red");
        } else {
            $('#passwordCheckError').text("비밀번호가 일치합니다.").css("color", "green");
        }
    });

    /* ----------------------------------------
       07. 전화번호 구성
    ---------------------------------------- */
    function updatePhone() {
        const area = $('#areaCodeSelect').val();
        const mid = $('#middle').val().trim();
        const end = $('#end').val().trim();

        if (area && /^\d{3,4}$/.test(mid) && /^\d{4}$/.test(end)) {
            $('#phone').val(area + "-" + mid + "-" + end);
            checkPhoneDuplicate($('#phone').val());
        } else {
            $('#phone').val("");
            $('#phoneError').text("");
            $('#phoneChecked').val("false");
        }
    }

    $('#areaCodeSelect').on('change', updatePhone);

    $('#middle, #end').on('input', function () {
        this.value = this.value.replace(/[^0-9]/g, "");
        updatePhone();
    });

    function checkPhoneDuplicate(phone) {
        $.ajax({
            method: "GET",
            url: contextPath + "/register/phoneCheck",
            data: { phone: phone },
            dataType: "json",
            success: function (result) {
                if (result === true) {
                    $('#phoneError').text("이미 사용 중인 번호입니다.").css("color", "red");
                    $('#phoneChecked').val("false");
                } else {
                    $('#phoneError').text("사용 가능한 번호입니다.").css("color", "green");
                    $('#phoneChecked').val("true");
                }
            },
            error: function () {
                $('#phoneError').text("전화번호 확인 중 오류 발생").css("color", "red");
                $('#phoneChecked').val("false");
            }
        });
    }

    /* ----------------------------------------
       08. 이메일 구성
    ---------------------------------------- */
    $('#emailDomain').prop('disabled', false);

    $('#emailDomainSelect').on('change', function () {
        const selectedDomain = $(this).val();

        if (selectedDomain === "") {
            $('#emailDomain').prop('disabled', false).val('');
        } else {
            $('#emailDomain').prop('disabled', true).val(selectedDomain);
        }

        updateEmail();
    });

    $('#emailId, #emailDomain').on('input', updateEmail);

    function updateEmail() {
    const emailId = $('#emailId').val().trim();
    const emailDomain = $('#emailDomain').val().trim();

    if (emailId && emailDomain) {
        // 이메일 아이디 검증
        if (!/^[a-zA-Z0-9_-]{3,}$/.test(emailId)) {
            $('#emailError').text("이메일 아이디는 최소 3글자 이상, 영문, 숫자, '-', '_'만 가능합니다.").css("color", "red");
            $('#emailChecked').val("false");
            return;
        }

        // 도메인 검증
        if (!/^[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$/.test(emailDomain)) {
            $('#emailError').text("도메인 형식이 올바르지 않습니다.").css("color", "red");
            $('#emailChecked').val("false");
            return;
        }

        const email = emailId + '@' + emailDomain;
        $('#email').val(email);
        $('#emailError').text("올바른 이메일입니다.").css("color", "green");
        checkEmailDuplicate(email);

    } else {
        $('#email').val('');
        $('#emailChecked').val("false");
    }
}



    function checkEmailDuplicate(email) {
        $.ajax({
            method: "GET",
            url: contextPath + "/register/emailCheck",
            data: { email: email },
            dataType: "json",
            success: function (result) {
                if (result === true) {
                    $('#emailError').text("이미 사용 중인 이메일입니다.").css("color", "red");
                    $('#emailChecked').val("false");
                } else {
                    $('#emailError').text("사용 가능한 이메일입니다.").css("color", "green");
                    $('#emailChecked').val("true");
                }
            },
            error: function () {
                $('#emailError').text("이메일 확인 중 오류 발생").css("color", "red");
                $('#emailChecked').val("false");
            }
        });
    }

/* ----------------------------------------
   09. 별명 실시간 검증 & 중복 체크
---------------------------------------- */
$('#nickname').on('input', function () {
    let nickname = $(this).val().trim();

    if (nickname.length === 0) {
        $('#nicknameError').text("별명을 입력해주세요.").css("color", "red");
        $('#nicknameChecked').val('false');
        return;
    } else if (nickname.length < 2) {
        $('#nicknameError').text("별명은 최소 2글자 이상이어야 합니다.").css("color", "red");
        $('#nicknameChecked').val('false');
        return;
    }

    let nicknameRegex = /^[가-힣a-zA-Z0-9]{2,10}$/;
    if (!nicknameRegex.test(nickname)) {
        $('#nicknameError').text("별명은 2~10자리 한글, 영문, 숫자만 가능합니다.").css("color", "red");
        $('#nicknameChecked').val('false');
        return;
    }

    // 형식 통과 시 중복 체크
    $.ajax({
        method: "GET",
        url: contextPath + "/register/nicknameCheck",
        data: { nickname: nickname },
        dataType: "json",
        success: function(result) {
            if (result === true) {
                $('#nicknameError').text("이미 사용 중인 별명입니다.").css("color", "red");
                $('#nicknameChecked').val('false');
            } else {
                $('#nicknameError').text("사용 가능한 별명입니다.").css("color", "green");
                $('#nicknameChecked').val('true');
            }
        },
        error: function() {
            $('#nicknameError').text("별명 확인 중 오류 발생").css("color", "red");
            $('#nicknameChecked').val('false');
        }
    });
});



    /* ----------------------------------------
       10. 폼 제출 최종 검증
    ---------------------------------------- */
    $('.join-form').submit(function () {

        /* 아이디 */
        let userId = $('#user_id').val().trim();
        if (!/^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{6,12}$/.test(userId) || $('#user_idChecked').val() !== 'true') {
            $('#userIdError').text("아이디를 확인해주세요.").css("color", "red");
            $('#user_id').focus();
            return false;
        }

        /* 비밀번호 */
        let password = $('#password').val();
        if (!/^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{6,12}$/.test(password)) {
            $('#passwordError').text("비밀번호를 확인해주세요.").css("color", "red");
            $('#password').focus();
            return false;
        }

        if (password !== $('#passwordCheck').val()) {
            $('#passwordCheckError').text("비밀번호가 일치하지 않습니다.").css("color", "red");
            $('#passwordCheck').focus();
            return false;
        }

        /* 이름 */
        let username = $('#username').val().trim();
        if (username.length === 0 || !/^[가-힣a-zA-Z]{2,35}$/.test(username)) {
            $('#usernameError').text("이름을 입력해주세요.").css("color", "red");
            $('#username').focus();
            return false;
        }

        /* 별명 */
        let nickname = $('#nickname').val().trim();
        if (nickname.length === 0) {
            $('#nicknameError').text("별명을 입력해주세요.").css("color", "red");
            $('#nickname').focus();
            return false;
        }

        /* 이메일 */
        let email = $('#email').val().trim();
        if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email) || $('#emailChecked').val() !== 'true') {

            $('#emailError').text("이메일을 확인해주세요.").css("color", "red");
            $('#emailId').focus();
            return false;
        }

        /* 성별 */
        if ($('input[name="gender"]:checked').length === 0) {
            $('#genderError').text("성별을 선택해주세요.").css("color", "red");
            return false;
        }

        /* 생년월일 */
        if ($('#birthDate').val().trim().length === 0) {
            $('#birthDateError').text("생년월일을 입력해주세요.").css("color", "red");
            $('#birthDate').focus();
            return false;
        }

        /* 전화번호 */
        let mid = $('#middle').val().trim();
        let end = $('#end').val().trim();

        if (!/^\d{3,4}$/.test(mid)) {
            $('#phoneError').text("중간번호는 3~4자리 숫자여야 합니다.").css("color", "red");
            $('#middle').focus();
            return false;
        }

        if (!/^\d{4}$/.test(end)) {
            $('#phoneError').text("끝번호는 4자리 숫자여야 합니다.").css("color", "red");
            $('#end').focus();
            return false;
        }

        updatePhone();

        if ($('#phone').val().length === 0 || $('#phoneChecked').val() !== 'true') {
            $('#phoneError').text("전화번호를 확인해주세요.").css("color", "red");
            $('#middle').focus();
            return false;
        }

        return true;
    });

});
