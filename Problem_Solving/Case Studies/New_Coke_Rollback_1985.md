# Product & Decision-Making Case Study: The 1985 Coca-Cola "New Coke" Rollback

* **Incident / Event:** Launch and Rollback of "New Coke" (Formula 7X-100)
* **Date:** April 23 – July 11, 1985 (79-Day Lifecycle)
* **Severity:** SEV-1 (Brand Equity Crisis & Domestic Market Share Collapse)
* **Core Systems Affected:** Flagship Product Line, Bottler Network, Consumer Trust, Supply Chain

---

## 1. Executive Summary
On April 23, 1985, The Coca-Cola Company retired its 99-year-old original formula and replaced it with a sweeter reformulation dubbed "New Coke." The decision was backed by nearly **200,000 blind taste tests** showing consumers preferred the new formula over both Pepsi and the original Coke. However, within days of launch, the company faced an unprecedented consumer revolt, bottler lawsuits, and plummeting sales in its core Southern markets. Just **79 days later**, leadership forced an emergency rollback, reintroducing the original formula as "Coca-Cola Classic."

---

## 2. The Three Contributing Factors (Root Cause)
Despite spending $4 million on market research, three critical flaws in Coca-Cola's testing methodology and decision-making led to the failure:

1. **The "Sip Test" Fallacy (Flawed Testing Methodology):** Coca-Cola relied heavily on single-sip blind taste tests (modeled after the "Pepsi Challenge"). In a one-ounce sip test, human palates naturally favor sweeter beverages. However, a sweeter formula becomes cloying over a full 12-ounce can, meaning the test failed to simulate real-world consumption.
2. **Removal of Brand & Emotional Context:** By testing liquids in unmarked white cups, researchers stripped away the Coca-Cola name, iconic red packaging, and 99 years of cultural nostalgia. They measured pure sensory preference while ignoring that consumers were buying an emotional identity, not just sugar water.
3. **Failure to Test the "Replacement" Scenario:** Researchers asked testers whether they preferred Formula A or Formula B, and whether they would buy it if it were Coca-Cola. They **never asked** how consumers would react if the original Coca-Cola was permanently discontinued to make room for the new version.

---

## 3. Incident Timeline (1985)
* **1975 – 1984 (The Trigger):** Pepsi launches the "Pepsi Challenge" blind taste campaign. Over a decade, Coca-Cola’s market share steadily erodes from 60% to under 24%, creating internal panic at Coke headquarters.
* **Late 1984:** Coca-Cola conducts ~200,000 blind taste tests. The new sweeter formula beats original Coke by 10–12 percentage points and beats Pepsi by 6–8 points.
* **April 23, 1985:** CEO Roberto Goizueta officially announces New Coke at Lincoln Center in New York, retiring the original 1886 formula.
* **May – June 1985:** Consumer backlash erupts nationwide. Coca-Cola’s hotline is flooded with up to **8,000 angry calls per day** (up from 400). Protest groups like "Old Cola Drinkers of America" form, consumers hoard old cases, and people pour New Coke into sewer drains on live television.
* **June 1985:** Independent bottlers—who had not been consulted on the formula change—threaten to sue Coca-Cola as warehouse inventories sit unsold across the American South.
* **July 11, 1985:** Coca-Cola executives hold an emergency press conference to apologize and announce the return of the original formula as **"Coca-Cola Classic,"** marking a full rollback after 79 days.

---

## 4. Key Analytical & Decision-Making Lessons

### A. Synthetic Benchmarks vs. Real-World Usage
A single-sip taste test is the consumer-goods equivalent of a synthetic micro-benchmark in software engineering. Optimizing for a 1-ounce sip ruined the experience of drinking a full 12-ounce bottle.
* **Lesson:** *Ensure your test metrics reflect end-to-end, real-world usage patterns rather than isolated, short-duration interactions.*

### B. Unmeasured Variables & Hidden Dependencies
Data only tells you what you ask it to measure. Because Coca-Cola’s research framework could not quantify nostalgia, tradition, or psychological ownership, executives treated those factors as zero.
* **Lesson:** *Good data paired with missing context leads to bad decisions. Quantitative metrics must always be paired with qualitative understanding of user attachment and workflow habits.*

### C. Big-Bang Cutovers vs. Parallel Rollouts
Instead of launching New Coke alongside the original formula (similar to a canary release or A/B rollout) and letting the market choose, Coca-Cola executed a forced, irreversible cutover. Removing the fallback option triggered immediate loss aversion among loyal users.
* **Lesson:** *Never force a "big-bang" replacement of a mission-critical or beloved product without giving users an opt-out or parallel migration path.*

### D. Speed of Rollback & Stakeholder Alignment
Once executives realized the severity of the backlash, they swallowed their pride and executed a rapid rollback in under three months—a move that ultimately revitalized sales and cemented Coca-Cola Classic's market dominance.
* **Lesson:** *Sunk-cost fallacy kills products. Having a viable rollback plan—and the humility to trigger it quickly—can turn a catastrophic launch into a long-term recovery.*

---

## 5. Classroom Discussion Prompts
1. **Metric Design:** If you were leading Coca-Cola's research team in 1984, how would you redesign the product testing experiment to capture both taste preference *and* emotional attachment/full-can consumption?
2. **Rollout Strategy:** How might the outcome have differed if Coca-Cola had launched New Coke as a separate SKU (like Diet Coke in 1982) rather than replacing the flagship product?
3. **Cross-Industry Parallels:** What modern tech or software product updates (e.g., UI overhauls, removed features, forced migrations) mirror the New Coke mistake of optimizing for metrics while ignoring user habits?

