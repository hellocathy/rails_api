class CreateSampleQuestions < ActiveRecord::Migration[6.1]
  def change
    Question.create(
      text: "What did you like most?",
      question_type: "short_answer",
      placeholder: "Tell us your experience (optional)",
      required: false
    )

    Question.create(
      text: "What did you like least?",
      question_type: "short_answer",
      placeholder: "Let us know how we can improve (optional)",
      required: false
    )

    Question.create(
      text: "Your email",
      question_type: "email",
      placeholder: "Your email address (optional)",
      required: false
    )
  end
end
