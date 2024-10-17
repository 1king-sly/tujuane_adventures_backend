"use client";

import { useState, useEffect } from "react";
import Image from "next/image";

const partners = [
  { name: "UNICEF", logo: "/logos/unicef.png" },
  { name: "WHO", logo: "/logos/who.png" },
  { name: "UN Women", logo: "/logos/un-women.png" },
  { name: "Save the Children", logo: "/logos/save-the-children.png" },
  { name: "Plan International", logo: "/logos/plan-international.png" },
  { name: "Girl Effect", logo: "/logos/girl-effect.png" },
];

const Partners = () => {
  const [currentPartners, setCurrentPartners] = useState(partners.slice(0, 4));

  useEffect(() => {
    const interval = setInterval(() => {
      setCurrentPartners((prev) => {
        const next = [...prev];
        next.push(partners[(partners.indexOf(next[3]) + 1) % partners.length]);
        next.shift();
        return next;
      });
    }, 3000);
    return () => clearInterval(interval);
  }, []);

  return (
    <section className="py-16 bg-gray-50">
      <div className="container">
        <h2 className="text-3xl font-bold text-center mb-12">Our Partners</h2>
        <div className="flex justify-center items-center space-x-8">
          {currentPartners.map((partner, index) => (
            <div
              key={index}
              className="w-40 h-40 flex items-center justify-center bg-white rounded-lg shadow-md transition-all duration-500"
            >
              <Image
                src={partner.logo}
                alt={partner.name}
                width={120}
                height={120}
                objectFit="contain"
              />
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Partners;