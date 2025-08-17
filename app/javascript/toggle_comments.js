document.addEventListener('turbo:load', () => {
  const toggleButtons = document.querySelectorAll('.toggle-comment');

  toggleButtons.forEach(button => {
    button.addEventListener('click', () => {
      const tweetId = button.dataset.tweetId;
      const commentWrapper = document.getElementById(`comment-${tweetId}`);

      if (commentWrapper) {
        const isHidden = commentWrapper.style.display === 'none';
        commentWrapper.style.display = isHidden ? 'block' : 'none';
      }
    });
  });
});

