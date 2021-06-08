
const $btn = document.getElementById('change');
const $petDiv = document.getElementById('my-pet');

$btn.onclick = e => {
    $petDiv.textContent = '못된 거북이!!';
};