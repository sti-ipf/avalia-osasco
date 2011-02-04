class ReportIndividual2
  def to_pdf
    Prawn::Document.generate("/tmp/doc.pdf") do
      flexible_table [
          ["hello", "wooorld", "H"],
          ["O", "Other", "Cell"]
        ], :headers => %W(hello world headers), :border_style => :grid do
          cells[1,0].rowspan = 2
          cells[1,1].colspan = 2
          cells[1,2].borders = [:left]
        end
    end
  end
end