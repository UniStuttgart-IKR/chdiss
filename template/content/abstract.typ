#import "@local/chdiss:0.1.0": *

Over the past decades, the global internet has evolved from a specialized communication tool into a fundamental societal utility, underpinning modern infrastructure with the vast majority of digital traffic traversing @metronetwork[metropolitan] and @corenetwork[core] @ipoptical transport networks.
As society depends more on these systems, ensuring their continuous operation is crucial.
This thesis contributes to the ongoing availability investigation of these infrastructures to enhance their capacity for robust, reliable networking.
Because the modern internet is a highly decentralized ecosystem of independent administrative domains, where operators are reluctant to share internal topological or operational data, this research is firmly rooted in @zerodisclosure scenarios.

As @multidomain networking becomes more complex, orchestrating @e2e connectivity across a fragmented mix of legacy protocols poses scalability and operational challenges.
@ibn:cap promises to simplify operations by turning complex configurations into high-level goals.
However, a comprehensive literature review reveals a lack of decentralized, @multidomain @ibn solutions for @zerodisclosure @ipoptical networks.
Leveraging @sdn to bridge this gap, this thesis uses a modularized @ibnoversdn architecture that confines intelligent decision-making exclusively to the intent domain and treats the @sdn controller as an underlying device driver.
With the introduction of the intent @dag and @crossdomain @intentdelegation, this architecture enables a multi-step compilation of connectivity intents while preserving each domain's confidentiality.
An intent lifecycle is imposed on all @e2e connections, facilitating automatic @restoration and seamless autonomous @multidomain networking.

However, architectural flexibility alone is not enough for reliable service delivery if routing decisions rely on flawed predictions.
Historically, routing algorithms rely on rigid, deterministic assumptions about equipment availability, leading to unquantified errors that cascade into @sla violations.
Challenging the status quo, this thesis pioneers the application of hierarchical Bayesian modeling to estimate the underlying availability of network equipment.
Specifically, two separate models are developed: one for estimating @intradomain link availability and another for @crossdomain connection availability.
By relying exclusively on readily available data, such as @uptime:pl, @downtime:pl, and external connection sensing, these models produce accurate probabilistic estimates in information-scarce environments with no @crossdomain information exchange.

@priam:hide
These architectural and modeling contributions are integrated into #emph[@priam:short (@priam:long)], our overarching availability-aware intent deployment mechanism.
Leveraging a @grooming\-enabled @rsa algorithm, @priam utilizes the probabilistic outputs of the Bayesian models to make calculated deployment decisions.
By incorporating a tunable @compliancetarget, @priam empowers operators to account for uncertainty, balancing intent admission rates with the risk of @sla violations.
Extensive simulations demonstrate that our approach significantly outperforms the conventional baseline model, which uses @experiencedavailability.
The proposed Bayesian approach improves, on average, the accuracy of availability estimation by #im($40 thin %$) for @intradomain links and by #im($25 thin %$) for @crossdomain connections compared to the baseline.
This superior accuracy yields benefits across multiple metrics while simultaneously providing a robust foundation that subsequent research can leverage to enhance its own predictive performance.
Primarily, it enables higher intent admission rates while simultaneously lowering the probability of @sla violations.
Furthermore, it reduces operational costs by allowing operators to negotiate less stringent @sla requirements with neighboring domains.
Ultimately, these contributions culminate in a robust, intent-driven framework that embraces mathematical uncertainty, leading towards reliable, autonomous operation of future @multidomain networks.

