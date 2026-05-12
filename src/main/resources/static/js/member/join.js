const total = document.querySelector("#userAgr");
const chs = document.querySelectorAll(".ch");



total.addEventListener("click", ()=>{
    let ch = document.querySelectorAll(".ch")
    ch.forEach((c)=>{
        c.checked=total.checked;
    });
})

chs.forEach((c) => {
    c.addEventListener("click", () => {
        // 현재 체크된 개별 버튼의 개수를 계산
        const checkedCount = document.querySelectorAll(".ch:checked").length;
        
        // 체크된 개수와 전체 개별 버튼의 개수가 같으면 total을 체크, 아니면 해제
        total.checked = (checkedCount === chs.length);
    });
});