# Relationship-based access control (ReBAC) #
Social networks as the basis for access control - use binary (or higher) predicates to describe relationships.

#### Types ####
* Poly-relational -- Encode diff types of relationships
* Multi-context -- Within diff contexts, you get access to diff/more info

#### How to represent? ####
A social network is a digraph with multiple edge types (according to relationship type).

#### Policies ####
Policy maps (owner, requester, relationship) to a boolean (access or not). Policy syntax: (see slide). Strict generalization of role-based access-control (a sort of parameterized role).  

## Trust Management ##
Framework for managing:
- security **policies** (access control)
- security **credentials** (authentication)
- **trust** relationships (delegation)

Principles: (see slide)  

## Datalog ##
A program is a set of rules (each rule/line is an implication right-to-left).  
After rules are defined, we present queries (see slide).  

#### SD3 ####
Distributed trust management language. SD3 extends datalog to allow reference to relations under control of some entity (keyholder). This allows construction of "chains of trust". This can represent classical access control (see slide). --> the `$` symbol basically restricts a reference to some namespace (like Java inner classes).

#### RT (Role-based Trust management) ####
A typesafe family of languages for trust management. Adds local roles, hierarchies, delegation, role intersections (see slide).  

RT1 adds parameterized roles (attributes with fields).  RT2 adds logical objects (roles for objects). RT<sup>T</sup> adds thresholds and separation of duty.
