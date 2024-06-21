
document.addEventListener('DOMContentLoaded', () => {

    const feedbackForm = document.getElementById('feedbackForm');
    const feedbackMessage = document.getElementById('feedbackMessage');
    const feedbackList = document.getElementById('feedbackList');

    feedbackForm.addEventListener('submit', (e) => {
        e.preventDefault();

        const name = document.getElementById('name').value;
        const email = document.getElementById('email').value;
        const feedback = document.getElementById('feedback').value;

        
        const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!regex.test(email)) {
            alert("Email invalid");
            return; 
        }

        const feedbackEntry = { name, email, feedback };
        saveFeedback(feedbackEntry);
        displayFeedback();

        feedbackForm.classList.add('hidden');
        feedbackMessage.classList.remove('hidden');
    });

    function saveFeedback(feedback) {
        let feedbacks = localStorage.getItem('feedbacks');
        if (feedbacks) {
            feedbacks = JSON.parse(feedbacks);
        } else {
            feedbacks = [];
        }
        feedbacks.push(feedback);
        if (feedbacks.length > 5) {
            feedbacks.shift();
        }
        localStorage.setItem('feedbacks', JSON.stringify(feedbacks));
    }

    function displayFeedback() {
        const feedbacks = JSON.parse(localStorage.getItem('feedbacks')) || [];
        feedbackList.innerHTML = feedbacks.map(f => `<p><strong>${f.name}, ${f.email}</strong>: ${f.feedback}</p>`).join('');
    }

    displayFeedback();
});


//daca imi mergea json cum trb
// document.addEventListener('DOMContentLoaded', () => {
//     const feedbackForm = document.getElementById('feedbackForm');
//     const feedbackMessage = document.getElementById('feedbackMessage');
//     const feedbackList = document.getElementById('feedbackList');

//     feedbackForm.addEventListener('submit', (e) => {
//         e.preventDefault();

//         const name = document.getElementById('name').value;
//         const email = document.getElementById('email').value;
//         const feedback = document.getElementById('feedback').value;

//         const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
//         if (!regex.test(email)) {
//             alert("Email invalid");
//             return;
//         }

//         const feedbackEntry = { name, email, feedback };

//         fetch('/submit', {
//             method: 'POST',
//             headers: {
//                 'Content-Type': 'application/x-www-form-urlencoded'
//             },
//             body: new URLSearchParams(feedbackEntry)
//         }).then(response => response.text())
//           .then(data => {
//               feedbackForm.classList.add('hidden');
//               feedbackMessage.classList.remove('hidden');
//               feedbackMessage.innerHTML = data;
//               displayFeedback();
//           });
//     });

//     function displayFeedback() {
//         fetch('/data')
//             .then(response => response.json())
//             .then(feedbacks => {
//                 feedbackList.innerHTML = feedbacks.map(f => `<p><strong>${f.name}, ${f.email}</strong>: ${f.feedback}</p>`).join('');
//             });
//     }

//     displayFeedback();
// });








