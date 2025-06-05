// Live Image Preview
const selectDisplayPoster = document.getElementById("event-display-poster")
const previewDisplayPoster = document.getElementById("preview-display-poster")

selectDisplayPoster.addEventListener('change', function () {
  previewDisplayPoster.src = '/posters/' + selectDisplayPoster.value;
})
const optionsNodeList = selectDisplayPoster.children;
for (const node of optionsNodeList) {
  node.addEventListener('mouseenter', function () {
    previewDisplayPoster.src = '/posters/' + node.value;
  })
  node.addEventListener('mouseleave', function () {
    previewDisplayPoster.src = '/posters/' + selectDisplayPoster.value;
  })
}

// Auto-adjust input heights
function autoAdjustHeight(element) {
  element.addEventListener('input', function () {
    this.style.height = 'auto'; // reset height
    this.style.height = (this.scrollHeight) + 'px';
  })
}

const inputs = {
  eventTitle: document.getElementById('event-title'),
  eventAccommodation: document.getElementById('event-accommodation'),
  eventParkingInstructions: document.getElementById('event-parking-instructions'),
  eventAdditionalInfo: document.getElementById('event-additional-info'),
  eventDescription: document.getElementById('event-description'),
}

Object.keys(inputs).forEach(key => {
  inputs[key].style.height = (inputs[key].scrollHeight) + 'px' // initial adjustment
  autoAdjustHeight(inputs[key]);
})

// Only allow numeric values
const maxCapacity = document.getElementById('event-max-capacity')
maxCapacity.addEventListener("beforeinput", function (e) {
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