require "question"

describe Question do
	describe ".create" do
    context "given complete and valid parameters" do
      it "returns zero" do
        expect(
        	Question.create(
        		text: 'This is the question',
        		question_type: '',
        		placeholder: 'This is a placeholder',
        		required: true
        	)
        ).to eq(true)
      end
    end

    # context "empty question type" do
    #   it "returns zero" do
    #     expect(StringCalculator.add("")).to eq(0)
    #   end
    # end

    # context "given complete parameters" do
    #   it "returns zero" do
    #     expect(StringCalculator.add("")).to eq(0)
    #   end
    # end

    # context "given complete parameters" do
    #   it "returns zero" do
    #     expect(StringCalculator.add("")).to eq(0)
    #   end
    # end
  end
end