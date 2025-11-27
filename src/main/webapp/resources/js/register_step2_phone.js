// 🔹 드롭다운에서 선택 → 첫 번째 전화번호 입력칸으로 복귀
document.getElementById("areaCodeSelect").addEventListener("change", function () {
    const selectedValue = this.value;
    const areaCodeInput = document.getElementById("areaCode");

    areaCodeInput.value = selectedValue; // 선택한 지역번호를 첫 번째 입력칸에 설정
    updateFullPhone(); // 최종 phone 업데이트
});

// 🔹 중간번호 입력 시 업데이트
document.getElementById("middle").addEventListener("input", updateFullPhone);

// 🔹 끝번호 입력 시 업데이트
document.getElementById("end").addEventListener("input", updateFullPhone);

// 🔹 최종 phone 번호 조립 함수
function updateFullPhone() {
    const area = document.getElementById("areaCodeSelect").value;
    const mid = document.getElementById("middle").value;
    const end = document.getElementById("end").value;

    const fullPhone = area && mid && end ? `${area}-${mid}-${end}` : "";

    document.getElementById("phone").value = fullPhone;
}
