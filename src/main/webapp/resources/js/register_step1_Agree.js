// 전체 동의 및 필수 체크 활성화
const allAgree = document.getElementById('allAgree');
const checkboxes = document.querySelectorAll('input[name="agree_terms"], input[name="agree_privacy"], input[name="agree_marketing"]');
const nextBtn = document.getElementById('nextBtn');

allAgree.addEventListener('change', e => {
    checkboxes.forEach(checkbox => {
        checkbox.checked = allAgree.checked;
    });
    checkNextBtn();
});

checkboxes.forEach(checkbox => {
    checkbox.addEventListener('change', e => {
        allAgree.checked = [...checkboxes].every(chk => chk.checked);
        checkNextBtn();
    });
});

function checkNextBtn() {
    const requiredChecked = [...checkboxes].filter(chk => chk.required && chk.checked).length === 2;
    nextBtn.disabled = !requiredChecked;
}