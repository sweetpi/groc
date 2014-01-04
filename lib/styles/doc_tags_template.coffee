template = (segments) ->
  for segment, segmentIndex in segments when segment.tagSections?
    sections = segment.tagSections
    output = ''
	metaOutput = ''
	accessClasses = 'doc-section'

	accessClasses += " doc-section-#{tag.name}" for tag in sections.access if sections.access?

	segment.accessClasses = accessClasses

	firstPart = []
	firstPart.push tag.markdown for tag in sections.access if sections.access?
	firstPart.push tag.markdown for tag in sections.special if sections.special?
	firstPart.push tag.markdown for tag in sections.type if sections.type?

	metaOutput += "#{humanize.capitalize firstPart.join(' ')}"
	if sections.flags? or sections.metadata?
	  secondPart = []
	  secondPart.push tag.markdown for tag in sections.flags if sections.flags?
	  secondPart.push tag.markdown for tag in sections.metadata if sections.metadata?
	  metaOutput += " #{humanize.joinSentence secondPart}"

	output += "<span class='doc-section-header'>#{metaOutput}</span>\n\n" if metaOutput isnt ''

	output += "#{tag.markdown}\n\n" for tag in sections.description if sections.description?

	output += "#{tag.markdown}\n\n" for tag in sections.todo if sections.todo?

	if sections.params?
	  output += 'Parameters:\n\n'
	  output += "#{tag.markdown}\n\n" for tag in sections.params

	if sections.properties?
	  output += 'Properties:\n\n'
	  output += "#{tag.markdown}\n\n" for tag in sections.properties

	if sections.returns?
	  output += (humanize.capitalize(tag.markdown) for tag in sections.returns if sections.returns?).join('<br/>**and** ')

	if sections.howto?
	  output += "\n\nHow-To:\n\n#{humanize.gutterify tag.markdown, 0}" for tag in sections.howto

	if sections.example?
	  output += "\n\nExample:\n\n#{humanize.gutterify tag.markdown, 4}" for tag in sections.example

	segment.comments = output.split '\n'

module.exports = template