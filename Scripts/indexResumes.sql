USE Zippia;

CREATE INDEX cityIndx ON Resumes (city);
CREATE INDEX stateIndx ON Resumes (state);

CREATE INDEX w1TitleIndx ON Resumes (W1Title);
CREATE INDEX w2TitleIndx ON Resumes (W2Title);
CREATE INDEX w3TitleIndx ON Resumes (W3Title);
CREATE INDEX w4TitleIndx ON Resumes (W4Title);
-- CREATE INDEX w5TitleIndx ON Resumes (W5Title);
-- CREATE INDEX w6TitleIndx ON Resumes (W6Title);
-- CREATE INDEX w7TitleIndx ON Resumes (W7Title);
-- CREATE INDEX w8TitleIndx ON Resumes (W8Title);
-- CREATE INDEX w9TitleIndx ON Resumes (W9Title);
-- CREATE INDEX w10TitleIndx ON Resumes (W10Title);
-- CREATE INDEX w11TitleIndx ON Resumes (W11Title);
-- CREATE INDEX w12TitleIndx ON Resumes (W12Title);
-- CREATE INDEX w13TitleIndx ON Resumes (W13Title);
-- CREATE INDEX w14TitleIndx ON Resumes (W14Title);
-- CREATE INDEX w15TitleIndx ON Resumes (W15Title);

CREATE INDEX w1CityIndx ON Resumes (W1City);
CREATE INDEX w2CityIndx ON Resumes (W2City);
CREATE INDEX w3CityIndx ON Resumes (W3City);
CREATE INDEX w4CityIndx ON Resumes (W4City);
-- CREATE INDEX w5CityIndx ON Resumes (W5City);
-- CREATE INDEX w6CityIndx ON Resumes (W6City);
-- CREATE INDEX w7CityIndx ON Resumes (W7City);
-- CREATE INDEX w8CityIndx ON Resumes (W8City);
-- CREATE INDEX w9CityIndx ON Resumes (W9City);
-- CREATE INDEX w10CityIndx ON Resumes (W10City);
-- CREATE INDEX w11CityIndx ON Resumes (W11City);
-- CREATE INDEX w12CityIndx ON Resumes (W12City);
-- CREATE INDEX w13CityIndx ON Resumes (W13City);
-- CREATE INDEX w14CityIndx ON Resumes (W14City);
-- CREATE INDEX w15CityIndx ON Resumes (W15City);

CREATE INDEX w1OrganizationIndx ON Resumes (W1Organization);
CREATE INDEX w2OrganizationIndx ON Resumes (W2Organization);
CREATE INDEX w3OrganizationIndx ON Resumes (W3Organization);
CREATE INDEX w4OrganizationIndx ON Resumes (W4Organization);
-- CREATE INDEX w5OrganizationIndx ON Resumes (W5Organization);
-- CREATE INDEX w6OrganizationIndx ON Resumes (W6Organization);
-- CREATE INDEX w7OrganizationIndx ON Resumes (W7Organization);
-- CREATE INDEX w8OrganizationIndx ON Resumes (W8Organization);
-- CREATE INDEX w9OrganizationIndx ON Resumes (W9Organization);
-- CREATE INDEX w10OrganizationIndx ON Resumes (W10Organization);
-- CREATE INDEX w11OrganizationIndx ON Resumes (W11Organization);
-- CREATE INDEX w12OrganizationIndx ON Resumes (W12Organization);
-- CREATE INDEX w13OrganizationIndx ON Resumes (W13Organization);
-- CREATE INDEX w14OrganizationIndx ON Resumes (W14Organization);
-- CREATE INDEX w15OrganizationIndx ON Resumes (W15Organization);

CREATE INDEX e1UniversityIndx ON Resumes (E1School_University);
CREATE INDEX e2UniversityIndx ON Resumes (E2School_University);
CREATE INDEX e3UniversityIndx ON Resumes (E3School_University);
CREATE INDEX e4UniversityIndx ON Resumes (E4School_University);
-- CREATE INDEX e5UniversityIndx ON Resumes (E5School_University);
-- CREATE INDEX e6UniversityIndx ON Resumes (E6School_University);
-- CREATE INDEX e7UniversityIndx ON Resumes (E7School_University);
-- CREATE INDEX e8UniversityIndx ON Resumes (E8School_University);

CREATE INDEX e1CityIndx ON Resumes (E1City);
CREATE INDEX e2CityIndx ON Resumes (E2City);
CREATE INDEX e3CityIndx ON Resumes (E3City);
CREATE INDEX e4CityIndx ON Resumes (E4City);
-- CREATE INDEX e5CityIndx ON Resumes (E5City);
-- CREATE INDEX e6CityIndx ON Resumes (E6City);
-- CREATE INDEX e7CityIndx ON Resumes (E7City);
-- CREATE INDEX e8CityIndx ON Resumes (E8City);

CREATE INDEX e1StateIndx ON Resumes (E1State);
CREATE INDEX e2StateIndx ON Resumes (E2State);
CREATE INDEX e3StateIndx ON Resumes (E3State);
CREATE INDEX e4StateIndx ON Resumes (E4State);
-- CREATE INDEX e5StateIndx ON Resumes (E5State);
-- CREATE INDEX e6StateIndx ON Resumes (E6State);
-- CREATE INDEX e7StateIndx ON Resumes (E7State);
-- CREATE INDEX e8StateIndx ON Resumes (E8State);

CREATE INDEX coverLettrIndx ON Resumes (CoverLetterObjective(1000));
CREATE INDEX coverLetterParsIndx ON Resumes (CoverLetterParagraphs(1000));
