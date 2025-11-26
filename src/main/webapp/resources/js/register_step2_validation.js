$(function () {

// --------------------------
    // 생년월일 오늘까지만 선택 가능
    // --------------------------
    let today = new Date().toISOString().split('T')[0]; // "YYYY-MM-DD"
    $('#birthDate').attr('max', today);

    // --------------------------
    // 이름 실시간 정규식 검증
    // --------------------------
    $('#username').on('input', function() {
        var username = $(this).val().trim();  
        var nameRegex = /^[가-힣a-zA-Z]{2,35}$/;  

        if (username.length > 0) {
            if (username.length < 2) {
                $('#usernameError').text("이름은 2글자 이상이어야 합니다.").removeClass('success').addClass('error').css("color", "red");
            } else if (!nameRegex.test(username)) {
                $('#usernameError').text("한글, 영문 대소문자만 사용 가능하며 2~35자리로 입력해주세요.").removeClass('success').addClass('error').css("color", "red");
            } else {
                $('#usernameError').text("사용 가능한 이름입니다.").removeClass('error').addClass('success').css("color", "black");
            }
        } else {
            $('#usernameError').text(""); 
        }
    });

    // --------------------------
    // 아이디 입력 중 실시간 정규식 검증
    // --------------------------
    $('#user_id').on('input', function() {
        var userId = $(this).val().trim(); 
        var idRegex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{6,12}$/; 

        if (userId.length === 0) {
            $('#userIdError').text(""); 
            $('#password').prop('disabled', true); 
        } else if (!idRegex.test(userId)) {
            $('#userIdError').text("영문 소문자와 숫자를 포함한 6~12자리로 입력하세요.").css("color", "red");
            $('#password').prop('disabled', true); 
        } else {
            $('#userIdError').text("사용 가능한 아이디입니다. 중복 확인을 해주세요.").css("color", "blue");
            $('#password').prop('disabled', false); 
        }

        // 중복확인 다시 눌러야 하므로 hidden false로 초기화
        $('#user_idChecked').val('false');
    });

    // --------------------------
    // 아이디 중복 확인 버튼 클릭
    // --------------------------
    $('#check-btn').on('click', function() {
        let userId = $('#user_id').val().trim();
        let idRegex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{6,12}$/;

        if (userId.length === 0) {
            alert("아이디를 입력하세요.");
            $('#user_id').focus();
            return;
        }
        if (!idRegex.test(userId)) {
            alert("아이디는 6~12자리 소문자와 숫자를 포함해야 합니다.");
            $('#user_id').focus();
            return;
        }

        $.ajax({
            method: "GET",
            url: contextPath + "/register/idCheck",
            data: { user_id: userId },
            dataType: "json",
            success: function(result) {
                if (result.exists) {
                    alert("이미 사용 중인 아이디입니다.");
                    $('#user_idChecked').val('false');
                } else {
                    alert("사용 가능한 아이디입니다.");
                    $('#user_idChecked').val('true');
                }
            },
            error: function(xhr, status, error) {
                console.error("아이디 중복 확인 오류: ", error);
                $('#user_idChecked').val('false');
            }
        });
    });

    // --------------------------
    // 비밀번호 실시간 검증
    // --------------------------
    $('#password').on('input', function() {
        let password = $(this).val().trim();
        let passwordRegex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{6,12}$/;

        if (password.length > 0) {
            if (!passwordRegex.test(password)) {
                $('#passwordError').text("비밀번호는 6~12자리 소문자와 숫자를 포함해야 합니다.").css("color", "red");
            } else {
                $('#passwordError').text("사용 가능한 비밀번호입니다.").css("color", "green");
                $('#passwordCheck').prop('disabled', false); 
            }
        } else {
            $('#passwordError').text(""); 
            $('#passwordCheck').prop('disabled', true); 
        }
    });

    // --------------------------
    // 비밀번호 확인 입력 실시간 검증
    // --------------------------
    $('#passwordCheck').on('input', function() {
        let password = $('#password').val().trim();   
        let passwordCheck = $(this).val().trim();  

        if (password !== passwordCheck) {
            $('#passwordCheckError').text("비밀번호가 일치하지 않습니다.").css("color", "red"); 
        } else if (passwordCheck.length > 0) {
            $('#passwordCheckError').text("비밀번호가 일치합니다.").css("color", "black"); 
        } else {
            $('#passwordCheckError').text("");
        }
    });

    // --------------------------
    // 전화번호 입력 포맷팅
    // --------------------------
    $('#phone').on('input', function () {
        let raw = $(this).val().replace(/[^0-9]/g, "");
        if (raw.length > 11) raw = raw.substring(0, 11);

        let formatted = raw;
        if (raw.length >= 4 && raw.length <= 7) {
            formatted = raw.substring(0, 3) + "-" + raw.substring(3);
        } else if (raw.length >= 8) {
            formatted = raw.substring(0, 3) + "-" + raw.substring(3, 7) + "-" + raw.substring(7);
        }
        $(this).val(formatted);
        $('#phoneError').text("");
        $('#phoneChecked').val('false');
    });

    $('#phone').on('blur', function() {
        checkPhoneDuplicate(function() {});
    });

    function checkPhoneDuplicate(callback) {
        let phone = $('#phone').val().trim();
        if (phone.length === 0) {
            $('#phoneError').text("전화번호를 입력하세요.");
            $('#phoneChecked').val('false');
            callback(false);
            return;
        }

        let phoneRegex = /^010-\d{4}-\d{4}$/;
        if (!phoneRegex.test(phone)) {
            $('#phoneError').text("전화번호 형식이 올바르지 않습니다. 예: 010-0000-0000");
            $('#phoneChecked').val('false');
            callback(false);
            return;
        }

        $.ajax({
            method: "GET",
            url: contextPath + "/register/phoneCheck",
            data: { phone: phone },
            dataType: "json",
            success: function(result) {
                if (result.exists) {
                    $('#phoneError').text("이미 사용 중인 전화번호입니다.");
                    $('#phoneChecked').val('false');
                    callback(false);
                } else {
                    $('#phoneError').text("");
                    $('#phoneChecked').val('true');
                    callback(true);
                }
            },
            error: function(xhr, status, error) {
                console.error("전화번호 중복 확인 오류: ", error);
                $('#phoneChecked').val('false');
                callback(false);
            }
        });
    }

    // --------------------------
    // 폼 제출 시 유효성 체크
    // --------------------------
    $('.join-form').submit(function (e) {
        e.preventDefault();

        let username = $('#username').val().trim();
        let nameRegex = /^[가-힣a-zA-Z]{2,35}$/;  
        if (username.length === 0 || !nameRegex.test(username)) {
            alert("이름을 확인하세요.");
            $('#username').focus();
            return false;
        }

        let userId = $('#user_id').val().trim();
        let idRegex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{6,12}$/;
        if (userId.length === 0 || !idRegex.test(userId) || $('#user_idChecked').val() !== 'true') {
            alert("아이디를 확인하세요.");
            $('#user_id').focus();
            return false;
        }

        let password = $('#password').val();
        let passwordRegex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{6,12}$/;
        if (!passwordRegex.test(password) || password !== $('#passwordCheck').val()) {
            alert("비밀번호를 확인하세요.");
            $('#password').focus();
            return false;
        }

        let nickname = $('#nickname').val().trim();
        if (nickname.length === 0) {
            alert("별명을 입력하세요.");
            $('#nickname').focus();
            return false;
        }

        let email = $('#email').val().trim();
        let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            alert("올바른 이메일을 입력하세요.");
            $('#email').focus();
            return false;
        }

		let genderChecked = $('input[name="gender"]:checked').length;
if (genderChecked === 0) {
    alert("성별을 선택해주세요.");
    return false;
}
		

        let birthDate = $('#birthDate').val().trim();
        if (birthDate.length === 0) {
            alert("생년월일을 입력하세요.");
            $('#birthDate').focus();
            return false;
        }

        let phoneChecked = $('#phoneChecked').val();
        if (phoneChecked !== 'true') {
            alert("전화번호를 확인하세요.");
            $('#phone').focus();
            return false;
        }

        this.submit();
    });
});
