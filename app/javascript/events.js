// const selectImageCover = document.getElementById("event_cover_image")
// const previewImageCover = document.getElementById("cover_image_preview")

// const imageHandler = () => {
//   selectImageCover.addEventListener("change", (e) => {
//     changeImagePreview();
//   })
// }

// const changeImagePreview = () => {
//   previewImageCover.src = "/assets/posters/" + selectImageCover.value;
// }

// imageHandler();

// Only allow numeric values
const max_capacity = document.getElementById('event-max-capacity')
max_capacity.addEventListener("beforeinput", function (e) {
  const nextVal =
    e.target.value.substring(0, e.target.selectionStart) +
    (e.data ?? '') +
    e.target.value.substring(e.target.selectionEnd)
    ;
  // console.log(nextVal)
  if (!/^(\d{0,7}|\d{3}-?\d{0,4}|)$/.test(nextVal)) {
    e.preventDefault();
  }
  return;
});