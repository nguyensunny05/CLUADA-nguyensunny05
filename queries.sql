SELECT employe.nom, service.nom
FROM employe
JOIN service On service.id = employe.service_id
ORDER BY service.nom,employe.nom

SELECT service.nom,COUNT(employe.nom)
FROM employe
JOIN service ON service.id = employe.service_id
GROUP BY service.nom 

SELECT SUM (prix_centimes) / 100
FROM transaction_cafe

SELECT boisson,COUNT(*) as nbDeCafe
FROM transaction_cafe
GROUP BY boisson
ORDER BY nbDeCafe DESC

SELECT employe.nom,employe.prenom,SUM(transaction_cafe.prix_centimes) /100 as fouDuCafe
FROM employe
JOIN transaction_cafe ON transaction_cafe.employe_id = employe.id
GROUP BY employe.nom,employe.prenom
ORDER BY fouDuCafe DESC

SELECT nom, prenom, AVG(nb_cafes_par_jour) as "moyenne_par_jour"
FROM (
    SELECT employe.nom, employe.prenom, DATE(transaction_cafe.horodatage) as "jour", COUNT(*) as "nb_cafes_par_jour"
    FROM employe
    JOIN transaction_cafe ON transaction_cafe.employe_id = employe.id
    GROUP BY DATE(transaction_cafe.horodatage), employe.nom, employe.prenom
) as "cafe_par_jour"
GROUP BY nom, prenom
HAVING AVG(nb_cafes_par_jour) >= 4

SELECT transaction_cafe.boisson,horodatage,employe_id
FROM employe
JOIN transaction_cafe ON transaction_cafe.employe_id = employe.id
WHERE employe.id = 3

SELECT horodatage,sens
FROM badgeage
WHERE EXTRACT (HOUR FROM horodatage) >= 21
ORDER BY horodatage ASC

SELECT employe.nom,employe.prenom,badgeage.porte,badgeage.horodatage
FROM badgeage
JOIN employe ON employe.id = badgeage.employe_id
WHERE badgeage.sens = 'entree' AND EXTRACT(HOUR FROM horodatage) >= 21
ORDER BY EXTRACT(HOUR FROM horodatage)ASC

SELECT badgeage.horodatage, badgeage.sens, badgeage.porte, badgeage.employe_id, conge.date_debut, conge.date_fin
FROM badgeage
JOIN conge ON conge.employe_id = badgeage.employe_id 
AND DATE (badgeage.horodatage) BETWEEN conge.date_debut AND conge.date_fin

SELECT DISTINCT transaction_cafe.horodatage, boisson
FROM conge
JOIN employe ON employe.id = conge.employe_id
JOIN badgeage ON badgeage.employe_id = employe.id
JOIN transaction_cafe ON transaction_cafe.employe_id = badgeage.employe_id
WHERE employe.id = '15' AND transaction_cafe.horodatage >= date_debut AND transaction_cafe.horodatage < date_fin

SELECT employe.prenom,employe.nom,acces_parking.horodatage,acces_parking.sens
from acces_parking
JOIN employe ON employe.id = acces_parking.employe_id
where acces_parking.horodatage::time > '21:00'

SELECT badgeage.horodatage,badgeage.sens,badgeage.porte
FROM badgeage
WHERE employe_id = 16
AND badgeage.horodatage::date IN ('2026-06-16','2026-06-17','2026_06-18')
ORDER BY badgeage.horodatage;