import { defineCollection, z } from 'astro:content';

const consoles = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    slug: z.string(),
    brand: z.string(),
    model: z.string(),
    price_eur: z.number(),
    os: z.string(),
    ideal_for: z.string(),
    image: z.string().optional(),
    amazon_url: z.string().optional(),
    aliexpress_url: z.string().optional(),
    screen_size: z.string().optional(),
    screen_type: z.string().optional(),
    cpu: z.string().optional(),
    ram: z.string().optional(),
    storage: z.string().optional(),
    battery: z.string().optional(),
    tagline: z.string().optional(),
  }),
});

export const collections = {
  consoles,
};