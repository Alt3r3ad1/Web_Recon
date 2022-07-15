#!/bin/bash
if [[ $1 = ""||$2 = "" ]]; then
echo "Web_Recon by:Alt3r3ad1"
echo "Method for use: ./WebRecon.sh 'target.com' 'wordlist.txt'"
echo "Scanned files: .txt, .pdf, .php, .aspx, .js, .xml (include sitemap and robots)"
else

echo "---------------MAPPING SUBDOMAINS---------------"
for subdomain in $(cat ./$2 2>/dev/null)
do
host $subdomain.$1 | grep -v "NXDOMAIN"
done

echo -e "\n---------------LISTING DIRECTORIES---------------"
fileFound=0
for word in $(cat ./$2 2>/dev/null)
do
answer=$(curl -s -o /dev/null -w "%{http_code}" -H "User-Agent: Mozilla/5.0" $1/$word/)
if [ $answer == "200" ]
then
echo "Found DIRECTORY: $1/$word"
fileFound=1
fi
if [ $answer == "401" ] || [ $answer == "403" ]
then
echo "Found DIRECTORY: $1/$word (Unauthorized or Forbidden)"
fileFound=1
fi
done
if [ $fileFound == 0 ]
then
echo "No DIRECTORIES found for the wordlist selected"
fileFound=1
fi

echo -e "\n----------------LISTING .TXT FILES----------------"
for word in $(cat ./$2 2>/dev/null)
do
answertxt=$(curl -s -o /dev/null -w "%{http_code}" -H "User-Agent: Mozilla/5.0" $1/$word.txt)
if [ $answertxt == "200" ]
then
echo "File TXT found: $1/$word.txt"
fileFound=2
fi
if [ $answertxt == "401" ] || [ $answertxt == "403" ]
then
echo "File TXT found: $1/$word (Unauthorized or Forbidden)"
fileFound=2
fi
done
if [ $fileFound == 1 ]
then
echo "No TXT file found for the wordlist selected"
fileFound=2
fi

echo -e "\n----------------LISTING .PDF FILES----------------"
for word in $(cat ./$2 2>/dev/null)
do
answerpdf=$(curl -s -o /dev/null -w "%{http_code}" -H "User-Agent: Mozilla/5.0" $1/$word.pdf)
if [ $answerpdf == "200" ]
then
echo "File PDF found: $1/$word.pdf"
fileFound=3
fi
if [ $answerpdf == "401" ] || [ $answerpdf == "403" ]
then
echo "File PDF found: $1/$word (Unauthorized or Forbidden)"
fileFound=3
fi
done
if [ $fileFound == 2 ]
then
echo "No PDF file found for the wordlist selected"
fileFound=3
fi

echo -e "\n----------------LISTING .PHP FILES----------------"
for word in $(cat ./$2 2>/dev/null)
do
answerphp=$(curl -s -o /dev/null -w "%{http_code}" -H "User-Agent: Mozilla/5.0" $1/$word.php)
if [ $answerphp == "200" ]
then
echo "File PHP found: $1/$word.php"
fileFound=4
fi
if [ $answerphp == "401" ] || [ $answerphp == "403" ]
then
echo "File PHP found: $1/$word (Unauthorized or Forbidden)"
fileFound=4
fi
done
if [ $fileFound == 3 ]
then
echo "No PHP file found for the wordlist selected"
fileFound=4
fi

echo -e "\n----------------LISTING .ASPX FILES----------------"
for word in $(cat ./$2 2>/dev/null)
do
answeraspx=$(curl -s -o /dev/null -w "%{http_code}" -H "User-Agent: Mozilla/5.0" $1/$word.aspx)
if [ $answeraspx == "200" ]
then
echo "File ASPX found: $1/$word.aspx"
fileFound=5
fi
if [ $answeraspx == "401" ] || [ $answeraspx == "403" ]
then
echo "File ASPX found: $1/$word (Unauthorized or Forbidden)"
fileFound=5
fi
done
if [ $fileFound == 4 ]
then
echo "No ASPX file found for the wordlist selected"
fileFound=5
fi

echo -e "\n----------------LISTING .JS FILES----------------"
for word in $(cat ./$2 2>/dev/null)
do
answerjs=$(curl -s -o /dev/null -w "%{http_code}" -H "User-Agent: Mozilla/5.0" $1/$word.js)
if [ $answerjs == "200" ]
then
echo "File JS found: $1/$word.js"
fileFound=6
fi
if [ $answerjs == "401" ] || [ $answerjs == "403" ]
then
echo "File JS found: $1/$word (Unauthorized or Forbidden)"
fileFound=6
fi
done
if [ $fileFound == 5 ]
then
echo "No JS file found for the wordlist selected"
fileFound=6
fi

echo -e "\n----------------LISTING .XML FILES----------------"
for word in $(cat ./$2 2>/dev/null)
do
answerxml=$(curl -s -o /dev/null -w "%{http_code}" -H "User-Agent: Mozilla/5.0" $1/$word.xml)
if [ $answerxml == "200" ]
then
echo "File XML found: $1/$word.xml"
fileFound=7
fi
if [ $answerxml == "401" ] || [ $answerxml == "403" ]
then
echo "File XML found: $1/$word (Unauthorized or Forbidden)"
fileFound=7
fi
done
if [ $fileFound == 6 ]
then
echo "No XML file found for the wordlist selected"
fileFound=7
fi

echo -e "\n----------------SITEMAP----------------"
answersitemap=$(curl -s -o /dev/null -w "%{http_code}" -H "User-Agent: Mozilla/5.0" $1/sitemap.xml)
if [ $answersitemap == "200" ]
then
echo "File SITEMAP found: $1/sitemap.xml"
fileFound=8
fi
if [ $answersitemap == "401" ] || [ $answersitemap == "403"  ]
then
echo "File SITEMAP found: $1/robots.txt (Unauthorized or Forbidden)"
fileFound=9
fi
if [ $fileFound == 7 ]
then
echo "No SITEMAP file found"
fileFound=8
fi

echo -e "\n----------------ROBOTS----------------"
answerrobots=$(curl -s -o /dev/null -w "%{http_code}" -H "User-Agent: Mozilla/5.0" $1/robots.txt)
if [ $answerrobots == "200" ]
then
echo "File ROBOTS found: $1/robots.txt"
fileFound=9
fi
if [ $answerrobots == "401" ] || [ $answerrobots == "403"  ]
then
echo "File ROBOTS found: $1/robots.txt (Unauthorized or Forbidden)"
fileFound=9
fi
if [ $fileFound == 8 ]
then
echo "No ROBOTS file found"
fileFound=9
fi

fi
