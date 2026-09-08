#import "/peripherals/myconstants.typ" as CONSTS
#import "/peripherals/myfunctions.typ": r, kpi, rkpi, myqty, ffont, eqref, im, todo

In den letzten Jahrzehnten hat sich das globale Internet von einem spezialisierten Kommunikationswerkzeug zu einer grundlegenden gesellschaftlichen Ressource entwickelt, die das Fundament der modernen Infrastruktur bildet. 
Dabei wird der weitaus größte Teil des digitalen Datenverkehrs über @metronetwork[Metropolitan-] und @corenetwork[Core-]@ipoptical[IP-Optical]\-Transportnetzwerke abgewickelt.
Da die Gesellschaft zunehmend von diesen Systemen abhängt, kommt der Gewährleistung ihres kontinuierlichen Betriebs entscheidende Bedeutung zu.
Diese Dissertation trägt zur fortlaufenden Untersuchung der Verfügbarkeit dieser Infrastrukturen bei, um deren Kapazität für eine robuste und zuverlässige Vernetzung zu verbessern.
Da das moderne Internet ein stark dezentralisiertes Ökosystem unabhängiger administrativer Domänen ist, in dem Betreiber nur ungern interne topologische oder operative Daten teilen, ist diese Arbeit konsequent auf @zerodisclosure[Zero-Disclosure]-Szenarien ausgerichtet.

Mit der zunehmenden Komplexität der @multidomain[Multi-Domain]-Vernetzung bringt die Orchestrierung der @e2e[End-to-End]-Konnektivität über eine fragmentierte Mischung von Legacy-Protokollen hinweg Herausforderungen für Skalierbarkeit und Betrieb mit sich.
@ibn[Intent-Based-Networking (IBN)] verspricht, den Betrieb zu vereinfachen, indem komplexe Konfigurationen in übergeordnete Ziele überführt werden.
Eine umfassende Literaturrecherche zeigt jedoch einen Mangel an dezentralisierten @multidomain[Multi-Domain]-@ibn\-Lösungen für @zerodisclosure[Zero-Disclosure]-@ipoptical[IP-Optical]-Netzwerke.
Um diese Lücke unter Nutzung von @sdn[Software-Defined-Networking (SDN)] zu schließen, verwendet diese Arbeit eine modularisierte @ibnoversdn\-Architektur, die die intelligente Entscheidungsfindung ausschließlich auf die Intent-Domäne beschränkt und den @sdn\-Controller als reinen Gerätetreiber (Device Driver) behandelt.
Mit der Einführung des Intent @dag[Directed-Acyclic-Graph (DAG)] und der @crossdomain[Cross-Domain]-@intentdelegation[Intent-Delegation] ermöglicht diese Architektur eine mehrstufige Kompilierung von Konnektivitäts-Intents unter Wahrung der Vertraulichkeit jeder Domäne.
Alle @e2e[End-to-End]-Verbindungen durchlaufen einen definierten Intent-Lifecycle, der eine automatische Wiederherstellung (@restoration:cap) und eine nahtlose autonome @multidomain[Multi-Domain]-Vernetzung ermöglicht.

Architektonische Flexibilität allein reicht jedoch für eine zuverlässige Servicebereitstellung nicht aus, wenn Routing-Entscheidungen auf fehlerhaften Vorhersagen beruhen.
Historisch gesehen stützen sich Routing-Algorithmen auf starre, deterministische Annahmen über die Verfügbarkeit der Netzwerkkomponenten, was zu nicht quantifizierten Fehlern führt, die @sla[Service-Level-Agreement (SLA)]-Verletzungen zur Folge haben.
Entgegen dem etablierten Vorgehen wendet diese Arbeit erstmals hierarchische Bayes'sche Modellierung an, um die tatsächliche Verfügbarkeit von Netzwerkkomponenten zu schätzen.
Konkret werden zwei separate Modelle entwickelt: eines zur Schätzung der @intradomain[Intra-Domain]-Link-Verfügbarkeit und ein weiteres für die @crossdomain[Cross-Domain]-Verbindungsverfügbarkeit.
Indem sie sich ausschließlich auf leicht verfügbare Daten wie @uptime[Uptimes], @downtime[Downtimes] und die Daten einer externen Verbindungsüberwachung stützen, liefern diese Modelle präzise probabilistische Schätzungen in informationsarmen Umgebungen ohne jeglichen @crossdomain[Cross-Domain]-Informationsaustausch.

Diese Beiträge zu Architektur und Modellierung werden in @priam[PRIAM (Provisioning Risk-Aware Intents Across Multi-Domains)] integriert, dem übergreifenden Availability-Aware-Intent-Deployment-Mechanismus.
Unter Verwendung eines @grooming[grooming]-fähigen @rsa[Routing and Spectrum Assignment (RSA)] Algorithmus nutzt @priam die probabilistischen Erkenntnisse aus den Bayes'schen Modellen, um fundierte Deployment-Entscheidungen zu treffen.
Durch die Einbindung eines anpassbaren @compliancetarget[Compliance Targets] befähigt @priam die Betreiber, Unsicherheiten zu berücksichtigen und die Intent-Admission-Rates mit dem Risiko von @sla\-Verletzungen abzuwägen.
Umfangreiche Simulationen zeigen, dass unser Ansatz das konventionelle Ausgangsmodell, das die @experiencedavailability[empirische Verfügbarkeit] verwendet, deutlich übertrifft.
Der vorgestellte Bayes'sche Ansatz verbessert die Genauigkeit der Verfügbarkeitsschätzung im Durchschnitt um #im($40 thin %$) für @intradomain[Intra-Domain]-Links und um #im($25 thin %$) für @crossdomain[Cross-Domain]-Verbindungen im Vergleich zum Ausgangsmodell.
Diese überlegene Genauigkeit bringt Vorteile über mehrere Kennzahlen hinweg und bietet gleichzeitig ein robustes Fundament, das nachfolgende Arbeiten nutzen können, um ihre eigene Vorhersagegüte zu verbessern.
Vor allem ermöglicht der Ansatz höhere Intent-Admission-Rates und senkt zugleich die Wahrscheinlichkeit von @sla\-Verletzungen.
Darüber hinaus reduziert es die Betriebskosten, indem es den Betreibern ermöglicht, weniger strenge @sla\-Anforderungen mit benachbarten Domänen auszuhandeln.
Letztendlich münden diese Beiträge in ein robustes, intent-gesteuertes Framework, das mathematische Unsicherheit einbezieht und auf den zuverlässigen, autonomen Betrieb zukünftiger @multidomain[Multi-Domain]-Netzwerke abzielt.
