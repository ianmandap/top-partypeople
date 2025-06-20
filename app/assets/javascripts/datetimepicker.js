import { Calendar } from 'vanilla-calendar-pro';

const startDateInput = document.getElementById('calendar-input');

const dateFormatOptions = { weekday: 'short', month: 'short', day: 'numeric' }
const options = {
  selectedTime: startDateInput.dataset.time, // 'hh:mm aa'
  selectedDates: [startDateInput.dataset.date], // ['YYYY-MM-DD'] 
  dateMin: 'today',
  selectedTheme: 'light',
  inputMode: true,
  positionToInput: 'auto',
  selectionTimeMode: 12,
  onChangeTime(self) {
    this.onChangeToInput(self);
  },
  onChangeToInput(self) {
    if (!self.context.inputElement) return;
    if (self.context.selectedDates[0]) {
      const formattedDate = new Date(self.context.selectedDates[0]).toLocaleDateString('en-US', dateFormatOptions);
      self.context.inputElement.value = `${formattedDate} · ${self.context.selectedTime}`;
      // if you want to hide the calendar after picking a date
      // self.hide();
    } else {
      self.context.inputElement.value = '';
    }
  },
};
const calendarInput = new Calendar('#calendar-input', options);
calendarInput.init();