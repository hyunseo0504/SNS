let cropper;
    const name = "${name}"; // 서버에서 전달받은 'post' 또는 'story'
    const fileInput = document.getElementById('fileInput');
    const preview = document.getElementById('imagePreview');
    const placeholder = document.getElementById('placeholder');
    const form = document.getElementById('uploadForm');

    fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                placeholder.style.display = 'none';
                const oldImg = preview.querySelector('img');
                if(oldImg) oldImg.remove();

                const img = document.createElement('img');
                img.id = 'cropTarget';
                img.src = event.target.result;
                preview.appendChild(img);
                
                if(cropper) cropper.destroy();
                
                // 모드에 따라 비율 설정
                const targetRatio = (name === 'story') ? 9 / 16 : 1 / 1;
                
                cropper = new Cropper(img, {
                    aspectRatio: targetRatio, // 여기서 비율이 결정됨!
                    viewMode: 1,
                    autoCropArea: 1,
                    background: false,
                    dragMode: 'move'
                });
            }
            reader.readAsDataURL(file);
        }
    });

    form.addEventListener('submit', function(e) {
        if (!cropper) return;
        e.preventDefault();

        // 스토리일 경우 세로가 더 길게 해상도 조절 (예: 720x1280)
        const canvasOptions = (name === 'story') 
            ? { width: 720, height: 1280 } 
            : { width: 600, height: 600 };

        cropper.getCroppedCanvas(canvasOptions).toBlob(function(blob) {
            const fileName = fileInput.files[0].name;
            const croppedFile = new File([blob], fileName, { type: 'image/jpeg' });
            const dataTransfer = new DataTransfer();
            dataTransfer.items.add(croppedFile);
            fileInput.files = dataTransfer.files;
            form.submit();
        }, 'image/jpeg');
    });