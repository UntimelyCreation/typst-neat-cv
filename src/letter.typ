#import "template.typ": *
#show: layout
#set text(size: 12pt)
#set page(
    paper: "a4",
    margin: (
        left: 1.2cm,
        right: 1.2cm,
        top: 1.2cm,
        bottom: 1.2cm,
    ),
)

#letterHeader(
    myAddress: [12 Cours Maréchal-Joffre \ 75003 Paris, France],
    recipientName: [ABC Company],
    recipientAddress: [32 Rue Michel Ange \ 75011 Paris, France],
    date: [November 1, 2023],
    subject: "Subject: Job Application for Senior Software Engineer"
)

Dear Hiring Manager,

#lorem(200)

Thank you for considering my application. I look forward to the opportunity to discuss my qualifications further.

Sincerely,

#letterSignature("/images/signature.png")
