require './IdolOnDemand'  # including our main ruby class... Remember to keep this both display.rb and IdolOnDemand.rb in same directory

# object creation
client = IdolOnDemand.new
# taking input and different choices for menu driven program
puts 'Enter the choice'
puts '1. Find Similar API '
puts '2. OCR Document API through url and asynchronous'
puts '3. Store Object and do an OCR Document through reference'
puts '4. OCR Document API through file option and synchronous'
puts '5. Sentiment Analysis API '
choice = gets.chomp 
case choice
when '1'
	puts client.findSimilar() ## this will call find Similar API
when '2'
	puts client.ocrDocumentUrl() ## this will call OCR Document API with parameter passed as URL and called is asynchronous
when '3'
	puts client.ocrDocumentStoreObject() ## this will call OCR Document API with extra usage of store object API 
when '4'
	puts client.ocrDocumentFile() ## this will call OCR Document API passing file
when '5'
	puts client.sentimentAnalysis() ## this will call sentimentAnalysis API 
else
	puts "Wrong Choice!!" ## Wrong choice enter by user
end
