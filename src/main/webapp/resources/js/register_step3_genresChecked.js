document.querySelectorAll('.genre-grid input[type="checkbox"]').forEach(input => {
    // 초기 선택 상태 반영
    if(input.checked) input.parentElement.classList.add('checked-label');

    input.addEventListener('click', function() {
        if(this.checked) {
            this.parentElement.classList.add('checked-label');
            
//             alert("T" + this.checked);
            this.setAttribute("checked","checked");
            
        } else {
            this.parentElement.classList.remove('checked-label');
            this.removeAttribute("checked","checked");
            
//             alert("F" + this.checked);
            
        }
    });
});
