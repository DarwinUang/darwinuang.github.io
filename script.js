function uploadFile() {
    const fileInput = document.getElementById('fileInput');
    const file = fileInput.files[0];

    if (file) {
        const fileName = file.name;
        const fileURL = URL.createObjectURL(file);

        const fileList = document.getElementById('fileList');
        const listItem = document.createElement('li');
        const link = document.createElement('a');
        link.href = fileURL;
        link.textContent = fileName;
        link.download = fileName;

        listItem.appendChild(link);
        fileList.appendChild(listItem);
    }
}
