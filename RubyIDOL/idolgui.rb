require 'tk'
require './IdolOnDemand'

root = TkRoot.new
root.resizable(0,0)
root.title = "IDOL OnDemand API"
client = IdolOnDemand.new

f0 = TkFrame.new (root) do

  relief 'sunken'
  borderwidth 3
  background "green"
  pack('fill'=>'x')
end

f1 = TkFrame.new(root) do
  relief 'sunken'
  borderwidth 3
  background "red"
  padx 15
  pady 20
  pack('side' => 'left')
end

f2 = TkFrame.new (root) do

  relief 'groove'
  borderwidth 1
  background "yellow"
  padx 10
  pady 10
  pack('side' => 'right')
end

TkLabel.new(f0) do
  text 'HP IDOL OnDemand API'
  borderwidth 5
  font TkFont.new('times 14 bold')
  foreground  "red"
  relief      "groove"
  pack('fill' => 'x')
 end

TkButton.new(f1) {
  text 'FindSimilar'
  command {puts client.findSimilar()
	root.destroy}
  pack('fill' => 'x')
}
TkButton.new(f1) {
  text 'OCR Document and URL Async Call'
  command {puts client.ocrDocumentUrl()
	root.destroy}
  pack('fill' => 'x')
}
TkButton.new(f1) {
  text 'OCR Document and Store Object'
  command {puts client.ocrDocumentStoreObject()
	root.destroy}
  pack('fill' => 'x')
}
TkButton.new(f1) {
  text 'OCR Document and File'
  command {puts client.ocrDocumentFile()
			root.destroy}
  pack('fill' => 'x')
}
TkButton.new(f1) {
  text 'Sentiment Analysis'
  command {puts client.sentimentAnalysis()
	root.destroy}
  pack('fill' => 'x')
}
TkButton.new(f2) {
  text 'Quit'
  command { root.destroy}
  pack('fill' => 'x')
}
root.mainloop

